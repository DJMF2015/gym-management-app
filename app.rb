require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/members_controller')
require_relative('controllers/activity_controller')
require_relative('controllers/booking_controller')

#index
get '/' do
  erb( :index )
end
