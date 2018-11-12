
require 'test/unit'
require 'rack/test'

class ConnectTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end


  not_found do
    'This is nowhere to be found.'
  end

end
