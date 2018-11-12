require_relative( '../db/sql_runner' )


class Activity

  attr_accessor( :session, :spaces, :description, :time_of_day, :duration, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @session = options['session']
    @spaces = options['spaces']
    @description = options['description']
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
      time_of_day,
      duration
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING id"
    values = [@session, @spaces, @description,@time_of_day, @duration]
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
      time_of_day,
      duration
      ) =
      (
        $1, $2, $3, $4, $5
      )
      WHERE id = $6"
      values = [@session, @spaces, @description,@time_of_day, @duration, @id]
      SqlRunner.run(sql, values)
  end

  #READ/FIND ALL
  def self.all()
    sql = "SELECT * FROM activities"
    results = SqlRunner.run(sql)
    classes = map_items(results)
    return classes
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
      sql = "select activities.*, description from activities where id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Activity.new( results.first )
    end


    #find a certain member's classes that he/she is booked for OKAY/PASS
    def member_bookings()
      sql= "SELECT  m.first_name, m.last_name , activities.session, activities.description, activities.id  FROM activities INNER JOIN bookings ON bookings.activities_id = activities.id INNER JOIN members m ON bookings.members_id = m.id WHERE m.id =$1 ORDER BY activities.id, m.last_name"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return result.map{|activity| Activity.new( activity)}
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
