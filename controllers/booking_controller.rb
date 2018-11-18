require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/member.rb' )
require_relative( '../models/activity.rb' )
require_relative( '../models/booking.rb' )

get '/bookings/staff' do
  erb(:"bookings/staff")
end

get '/bookings' do
  @bookings = Booking.all
  @activities = Activity.all
  erb ( :"bookings/index" )
end

get '/bookings/new' do
  @members = Member.all
  @activities = Activity.activities_with_spaces()
  @membership_type = Member.check_memberships()
  erb(:"bookings/new")
end

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to("/bookings")
end

post '/bookings/:id/delete' do
  Booking.delete(params[:id])
  redirect to("/bookings")
end

not_found do
  erb(:error)
end
