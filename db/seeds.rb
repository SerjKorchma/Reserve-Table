Reservation.all.destroy_all

8.times do |i|
  table = i + 1
  Reservation.create(table_number: table, start_time: table.days.from_now, end_time: table.days.from_now + 2.hours)
end