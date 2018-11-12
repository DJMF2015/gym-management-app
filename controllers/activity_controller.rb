require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/member.rb' )
require_relative( '../models/activity.rb' )
require_relative( '../models/booking.rb' )
also_reload( '../models/*' )


get '/' do
  erb(:index)
end

not_found do
  erb(:error)
end

#FIND ALL
get '/activities' do
  @activities = Activity.all
  erb(:"activities/index")
end

#"show" route 'picks-up' id to displays & avoids
# creating the :id as a string when searching. Avoid conversion error
#CRETE
get '/activities/new' do
  @activities = Activity.all
  erb(:"activities/new")
end

# use params[:id] in the block that defines the route.
get '/activities/:id/show' do  #   SHOW
  @activity = Activity.find( params['id']) # or 'id'?
  erb(:"activities/show")
end

#sinatra reads top-down. update method accepts :id from create
get '/activities/:id/edit' do #EDIT
  @activity = Activity.find(params[:id])
  erb (:"activities/edit")
end

#MODIFY/UPDATE
post '/activities/:id' do
  Activity.new(params).update
  redirect to '/activities' #{params['id']}"
end

#SAVE
post '/activities' do  # CREATE
  @activity = Activity.new(params)
  @activity.save() #'id'
  erb (:"activities/create")
end

#DELETE
post '/activities/:id/delete' do
  Activity.delete(params[:id])
  redirect to("/activities")
end
