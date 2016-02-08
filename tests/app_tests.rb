ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'test/unit'

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end


end
