require_relative( '../db/sql_runner' )
require 'date'
require 'time'

class Member

  attr_accessor( :first_name, :last_name, :membership, :id )

  def initialize( options )
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @membership = options['membership']
  end

  #CREATE
  def save()
    sql = "INSERT INTO members
    (
      first_name,
      last_name,
      membership
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@first_name, @last_name, @membership]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE members
    SET
    (
      first_name,
      last_name,
      membership

      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@first_name, @last_name, @membership, @id]
      SqlRunner.run(sql, values)
    end

    #READ/FIND ALL
    def self.all()
      sql = "SELECT * FROM members"
      results = SqlRunner.run(sql)
      members = map_items(results)
      return members
    end

    #FIND by id
    def self.find( id )
      sql = "SELECT * FROM members
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Member.new( results.first )
    end


    # find all upcoming classes a customer is booked for by id PASS
    def activities()
      sql = "SELECT a.*  FROM activities a INNER JOIN bookings b ON b.activities_id = a.id WHERE b.members_id =$1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return  result.map { |session| Activity.new( session) }
    end

    #return all members whith prmium membership
    def self.premium?()
      sql = "SELECT m.* from members m where membership like '%st%' " ;
      results = SqlRunner.run(sql)
      members = map_items(results)
      return members
    end

    # Helper method return true if time is 'on-peak' after 5 pm or before 9am
    def on_peak?()
      on_peak  =  Time.parse "17:00pm"
      on_peak_am  =  Time.parse "09:00am"
      current_time = Time.now
      if current_time > on_peak || current_time < on_peak_am
        return false
      else
        return true
      end
    end

    #find all premium members and return if 'eligible' to book for on-peak hours
    def self.check_memberships()
      all = premium?()
      return all.find_all { |members| members.on_peak?() }
    end

    #Delete by ID
    def self.delete(id)
      sql = "DELETE FROM members where id = $1"
      values = [id]
      SqlRunner.run( sql, values )
    end

    #Delete all
    def self.delete_all
      sql = "DELETE FROM members"
      SqlRunner.run( sql )
    end

    def self.map_items(results)
      return results.map { |member|  Member.new(member) }
    end

  end
