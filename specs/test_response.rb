
require 'test/unit'
require 'rack/test'

class ConnectTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def response()
    p response.code

    # worker = Fetcher::Worker.new
    # txt = worker.write( 'http://localhost:4567/members.txt' )
    # puts txt
  end

end
