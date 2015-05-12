FactoryGirl.define do
  factory :reservation do
    start_time 1.hour.from_now
    end_time 5.hour.from_now
    table_number 1
  end

end
