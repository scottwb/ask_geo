$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'ask_geo'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

#
# TODO: Update these with the values provided by askgeo.com for your account.
#
ASKGEO_ACCOUNT_ID = 'XXXXXX'
ASKGEO_API_KEY    = 'XXXXXXXXXXXXXXXXXXXXXXXXXX'

RSpec.configure do |config|
  
end
