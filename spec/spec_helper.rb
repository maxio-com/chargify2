$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'chargify2'
require 'webmock/rspec'
require 'capybara/rspec'
require 'vcr'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include SpecHelperMethods
  config.extend VCR::RSpec::Macros
end

VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                :webmock
  c.default_cassette_options = { :record => :new_episodes }
end
