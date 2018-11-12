DROP TABLE IF EXISTS BOOKINGS;
DROP TABLE IF EXISTS MEMBERS;
DROP TABLE IF EXISTS ACTIVITIES;


CREATE TABLE MEMBERS(
  id serial8 primary key,
  first_name varchar(255),
  last_name varchar(255),
  membership varchar(255)
);

CREATE TABLE ACTIVITIES(
  id serial8 primary key,
  session varchar(255),
  spaces INT4,
  description varchar(255),
  time_of_day varchar(255), --time of day e 10am
  duration varchar(255) --length of activity/class
);

CREATE TABLE BOOKINGS(
  id serial8 primary key,
  members_id INT8 REFERENCES members(id) ON DELETE CASCADE, --maintain referential integrity
  activities_id INT8 REFERENCES activities(id) ON DELETE CASCADE
);
