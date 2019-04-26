## Project - Gym Management Web Application

### This project uses the following technologies:

HTML / CSS
Ruby
Sinatra
PostgreSQL and the PG gem

To run the following application, the requirments are specified below with instructions on how to run the application.

### Required:
- Ruby gem
- sinatra gem
- PostgreSql & PG Gem

#### Instructions:
From inside the terminal:
1. createdb gym
2. psql -d gym -f db/gym.sql
3. From within the 'db' folder: ruby db/seed.rb
4. Finally...
ruby app.rb will run the application on the localhost. Open a browser and in the address input localhost:4567/

### Objective:
To develop a content management style platform for a local gym to manage their memberships and the various classes they run. It should allow a manager to make bookings for a member and perform the following requirements.

## MVP
 - [x]  The app should allow the gym to create / edit / delete members
 - [x]  The app should allow the gym to create / edit / delete classes
 - [x]  The app should show a list of all upcoming classes
 - [X]  The app should allow the gym to add members to specific classes
 - [X]  The app should show all members that are registered for a particular class

## Possible Extensions
 - [x] Classes could have a maximum capacity, and users can only be added while there is space remaining. Y
 - [x] The gym could be able to give its members Premium or Standard membership. Standard members can only be signed up for classes during off-peak hours.

![alt text](gym.gif 'gym management')
