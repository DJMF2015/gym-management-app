require_relative( "../models/member.rb" )
require_relative( "../models/activity.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")
# -----------------------------------
#seeds.rb file

Booking.delete_all()
Member.delete_all()
Activity.delete_all()


member1 = Member.new({
  "first_name" => "David",
  "last_name" => "Fulton",
  "membership" => 'premium'
  })
member1.save()

member2 = Member.new({
    "first_name" => "John",
    "last_name" => "Smith",
    "membership" => 'standard'
    })
member2.save()

member3 = Member.new({
      "first_name" => "John",
      "last_name" => "McClane",
      "membership" => 'standard'
      })

member3.save()

member4 = Member.new({
        "first_name" => "Emily",
        "last_name" => "Jenkins",
        "membership" => 'premium'
        })

member4.save()
# -----------------------------------
activity1 = Activity.new({
  'session' => 'Circuits',
  'spaces' => 10,
  "description" => "These classes are for anyone that loves music and energy.",
 'instructor' => 'Joe Strongarms',
  "time_of_day" => '11:00',
  "duration" => '60'

  })

activity1.save();

activity2 = Activity.new({
    'session' => 'Spin',
    'spaces' => 10,
    "description" => "An intensive spin-bike class designed to work your whole body!",
       'instructor' => 'Joe Cotton',
      "time_of_day" => '22:00',
    "duration" => '45'
    })

activity2.save()

 activity3 = Activity.new({
      'session' => 'Pilates',
      'spaces' => 15,
      "description" => "physical conditioning involving low-impact exercises & stretches",
       'instructor' => 'Emily Hurst',
       "time_of_day" => '09:00',
      "duration" => '30'
      })
activity3.save()

activity4 = Activity.new({
        'session' => 'PurePump',
        'spaces' => 3,
        "description" => "designed to develop your full body STRENGTH!",
         'instructor' => 'Magic Bob',
         "time_of_day" => '14:30',
        "duration" => '60'
        })

activity4.save()

booking1 = Booking.new({
          "members_id" => member1.id,
          "activities_id" => activity1.id,

        })
booking1.save()

booking2 = Booking.new({
          "members_id" => member2.id,
          "activities_id" => activity2.id,

        })
booking2.save()

booking3 = Booking.new({
          "members_id" => member3.id,
          "activities_id" => activity3.id,

        })
booking3.save()

booking4 = Booking.new({
          "members_id" => member4.id,
          "activities_id" => activity4.id,

        })
booking4.save()

booking5 = Booking.new({
          "members_id" => member3.id,
          "activities_id" => activity1.id,

        })
booking5.save()

booking6 = Booking.new({
          "members_id" => member1.id,
          "activities_id" => activity4.id,

        })

booking6.save()

 # activity2.find_customer_booking()
 activity1.upcoming_classes()
 # member3.members()
 member1.activities()
 booking1.member()
 booking1.activity()
 activity1.count_members
 activity4.classes_available()
 # p activity3.spaces_left()
 # p activity2.instructor
 # Member.premium?()
 # Activity.allocate_instructor_time_slots
 # p Member.premium?()
 # p member1.off_peak?()

binding.pry
nil
