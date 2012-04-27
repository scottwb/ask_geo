require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "AskGeo" do
  describe "#lookup" do
    before :each do
      @client = AskGeo.new(
        :account_id => ASKGEO_ACCOUNT_ID,
        :api_key    => ASKGEO_API_KEY
      )
    end

    it "should support points specified by comma-separated lat,lon string" do
      @client.lookup("47.62057,-122.349761")['TimeZone']['TimeZoneId'].should == 'America/Los_Angeles'
    end

    it "should support points specified by {:lat,:lon} hash" do
      @client.lookup(:lat => 47.62057, :lon => -122.349761)['TimeZone']['TimeZoneId'].should == 'America/Los_Angeles'
    end

    it "should get a single response for a single point" do
      response = @client.lookup("47.62057,-122.349761")
      response.should be_a Hash
      response['TimeZone']['TimeZoneId'].should == 'America/Los_Angeles'
      response['Point']['Latitude'].should be_within(0.000001).of(47.62057)
      response['Point']['Longitude'].should be_within(0.0000001).of(-122.349761)
      (response['TimeZone']['CurrentOffsetMs'] % 3600000).should == 0
      (-8..-7).should include(response['TimeZone']['CurrentOffsetMs'] / 3600000)
    end

    it "should get multiple responses for multiple points" do
      needle = {
        :lat => 47.62057,
        :lon => -122.349761
      }

      empire = {
        :lat  => 40.748529,
        :lon  => -73.98563
      }

      response = @client.lookup([needle, empire])
      response.should be_an Array
      response.should have(2).responses

      needle_response = response.first
      needle_response['TimeZone']['TimeZoneId'].should == 'America/Los_Angeles'
      needle_response['Point']['Latitude'].should be_within(0.000001).of(needle[:lat])
      needle_response['Point']['Longitude'].should be_within(0.0000001).of(needle[:lon])
      (needle_response['TimeZone']['CurrentOffsetMs'] % 3600000).should == 0
      (-8..-7).should include(needle_response['TimeZone']['CurrentOffsetMs'] / 3600000)

      empire_response = response.last
      empire_response['TimeZone']['TimeZoneId'].should == 'America/New_York'
      empire_response['Point']['Latitude'].should be_within(0.000001).of(empire[:lat])
      empire_response['Point']['Longitude'].should be_within(0.0000001).of(empire[:lon])
      (empire_response['TimeZone']['CurrentOffsetMs'] % 3600000).should == 0
      (-5..-4).should include(empire_response['TimeZone']['CurrentOffsetMs'] / 3600000)
    end

    it "should raise AskGeo::APIError on malformed points" do
      expect{@client.lookup("47.62057")}.to raise_exception AskGeo::APIError
    end
  end
end
