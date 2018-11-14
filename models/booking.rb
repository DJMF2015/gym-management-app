require_relative( '../db/sql_runner' )

class Booking

  attr_accessor( :members_id, :activities_id, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @members_id = options['members_id'].to_i
    @activities_id = options['activities_id'].to_i
  end

  #CREATE
  def save()
    sql = "INSERT INTO bookings
    (
      members_id,
      activities_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@members_id, @activities_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  #READ/FIND ALL
  def self.all()
    sql = "SELECT * FROM bookings ORDER BY bookings.id ASC"
    results = SqlRunner.run(sql)
    hash = results.map{|activity| Booking.new(activity)}
    return hash
  end

  #FIND by id
  def self.find( id )
    sql = "SELECT * FROM bookings
    WHERE id = $1 ORDER BY bookings.id ASC"
    values = [id]
    results = SqlRunner.run( sql, values ).first
    return Booking.new( results.first )
  end

  def member() #PASS
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [@members_id]
    results = SqlRunner.run( sql, values )
    return Member.new( results.first )
  end

  def activity()
    sql = "SELECT * FROM activities
    WHERE id = $1"
    values = [@activities_id]
    results = SqlRunner.run( sql, values )
    return Activity.new( results.first )
  end

  def premium?
    sql = "SELECT m.id, m.membership from members m WHERE id = $1"
    values= [@members_id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.new)
  end

 # def check_membership()
 #  type = premium?()
 #  # if Member.membership ==
 # end

  #Delete by ID
  def self.delete(id)
    sql = "DELETE FROM bookings where id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run( sql )
  end


  def self.map_items(results)
    return results.map { |bookings|  Booking.new(bookings) }
  end

end
