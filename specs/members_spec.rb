require('minitest/autorun')
require('minitest/rg')
require_relative('/Users/davidfulton/Desktop/codeclan/sinatra_app/models/activity.rb')
require_relative('/Users/davidfulton/Desktop/codeclan/sinatra_app/models/booking.rb')
require_relative('/Users/davidfulton/Desktop/codeclan/sinatra_app/models/member.rb')

class TestActivity < Minitest::Test

  def setup

    @activity1 = Activity.new('2')
  end

    def test_members_have_count
      expected = 4
      actual = Member.all().count
      assert_equal(expected, actual)
    end



  end
