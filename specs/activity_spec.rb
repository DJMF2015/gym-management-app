require('minitest/autorun')
require('minitest/rg')
require 'minitest/emoji'
require_relative('/Users/davidfulton/Desktop/codeclan/sinatra_app/models/activity.rb')
# require_relative('../booking.rb')
# require_relative('../member.rb')

class TestActivity < Minitest::Test

  def setup

    @activity1 = Activity.new("Circuits",10, "These classes are for anyone that loves music and energy.",
      "Joe Strongarms","11:00", "60")
  end

    def test_room_has_a_name
      expected  = 2
      assert_equal(expected, @activity1.count_members())
    end


  end
