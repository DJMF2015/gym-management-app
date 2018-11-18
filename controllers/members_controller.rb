require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/member.rb' )
require_relative( '../models/activity.rb' )
require_relative( '../models/booking.rb' )


get '/' do
  erb(:index)
end


#FIND ALL
get '/members' do
  @members = Member.all
  erb(:"members/index")
end

#"show" route 'picks-up' id to displays & avoids
# treating the :id as a string when searching. Avoids conversion error
#CREATE
get '/members/new' do
    @members = Member.all
  erb(:"members/new")
end

# use params[:id] in the block that defines the route.
get '/members/:id/show' do  #   SHOW
  @member= Member.find(params['id']) # or 'id'?
  erb(:"members/show")
end

#sinatra reads top-down. update method accepts :id from create
get '/members/:id/edit' do #EDIT
 @types = ['Standard','Premium']
 @member = Member.find(params[:id])#or ['id']
 erb (:"members/edit")
end

#MODIFY/UPDATE
post '/members/:id' do
  Member.new(params).update
  redirect to '/members' #{params['id']}"
end

#SAVE
post '/members' do  # CREATE
  @member = Member.new(params)
  @member.save() #s'id'
  erb (:"members/create")
end

#DELETE
post '/members/:id/delete' do
  Member.delete(params[:id])
  redirect to("/members")
end


not_found do
    erb(:error)
end
