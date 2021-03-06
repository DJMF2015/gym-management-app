
require_relative( '../db/sql_runner' )
require 'Date'

class Activity

  attr_accessor( :session, :spaces, :description, :instructor, :time_of_day, :duration, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @session = options['session']
    @spaces = options['spaces'].to_i if options['spaces']
    @description = options['description']
    @instructor = options['instructor']
    @time_of_day = options['time_of_day']
    @duration = options['duration']
  end

  #€CREATE
  def save()
    sql = "INSERT INTO ACTIVITIES
    (
      session,
      spaces,
      description,
      instructor,
      time_of_day,
      duration
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING id"
    values = [@session, @spaces, @description, @instructor, @time_of_day, @duration]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def update()
    sql = "UPDATE activities
    SET
    (
      session,
      spaces,
      description,
      instructor,
      time_of_day,
      duration
      ) =
      (
        $1, $2, $3, $4, $5, $6
      )
      WHERE id = $7"
      values = [@session, @spaces, @description, @instructor, @time_of_day, @duration, @id]
      SqlRunner.run(sql, values)
    end

    #READ/FIND ALL
    def self.all()
      sql = "SELECT * FROM activities"
      results = SqlRunner.run(sql)
      classes = map_items(results)
      return classes
    end

    #allocate 1 random instructor
    def self.random_instructor()
      sql = "SELECT a.instructor, a.session FROM ACTIVITIES a ORDER BY RANDOM() limit 1"
      results = SqlRunner.run( sql )
      return results.first['session']
    end

    #FIND by id
    def self.find( id )
      sql = "SELECT * FROM activities
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Activity.new( results.first )
    end

    #find classes available
    def upcoming_classes() #PASS
      sql = "select activities.* from activities where id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Activity.new( results.first )
    end

    #find members for particualar activity PASS
    def members()
      sql = "SELECT m.* FROM members m INNER JOIN bookings b ON b.members_id = m.id WHERE b.activities_id = $1"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map{ |member| Member.new(member)}
    end

    #helper method to allocate a future time slot to instructor
    def self.allocate_instructor_time_slots()
      now = Time.now
      future = now
      future.strftime('%H:%M:%p')
      @time_of_day = future + (60*60*24*7)
      return  @time_of_day.strftime('Class Booked for: %A, %B %C, %G @ %H:%M %p')
    end

    #count number of members
    def count_members()
      members().count #count method returning no of members from sql query (above
    end


    def class_full?()
      if count_members() >= @spaces
        return true
      else
        return false
      end
    end

    def self.activities_with_spaces()
      all = all()
      return all.find_all { |activity| activity.remaining_spaces() }
    end

    def remaining_spaces()
      empty_spaces = @spaces - count_members
      if  empty_spaces  > 0
        return  empty_spaces
      else
        return "No Space.Class Full"
      end
    end

    def css_display()
      css_add = "background-color: orange;"
      if @spaces > 0
        return  css_add
      else
        return "background-color: red;"
      end
    end
    #Delete by ID
    def self.delete(id)
      sql = "DELETE FROM activities where id = $1"
      values = [id]
      SqlRunner.run( sql, values )
    end

    #Delete all
    def self.delete_all
      sql = "DELETE FROM activities"
      SqlRunner.run( sql )
    end

    def self.map_items(results)
      return results.map { |classes|  Activity.new(classes) }
    end

  end
