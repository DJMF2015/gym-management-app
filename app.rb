require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/members_controller')
require_relative('controllers/activity_controller')
require_relative('controllers/booking_controller')
also_reload( './models/*' )

#index
get '/' do
  erb( :index )
end

get '/news' do
  erb( :news )
end
