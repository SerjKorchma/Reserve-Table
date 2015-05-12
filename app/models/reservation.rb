class Reservation < ActiveRecord::Base

  # table number must be present and between 1 and 12
  validates :table_number,
            presence: true,
            numericality: {greater_than: 0, less_than_or_equal_to: 12}

  # start time and end time must be present
  validates_presence_of :start_time, :end_time

  # start time must be in future and before end time
  validates_datetime :start_time,
                     on_or_after: lambda { DateTime.current },
                     before: :end_time

  # check some reservation
  validate :available_reservation

  # Returns all reservation in selected time
  # @return [Array<Reservation>] all reservation on specific time
  scope :reserved_times, -> (start_time, end_time) { where('(start_time < :end_time AND end_time >= :end_time)
                                                            OR (start_time <= :start_time AND end_time > :start_time)
                                                            OR (start_time > :start_time AND end_time < :end_time)
                                                    ', start_time: start_time, end_time: end_time) }

  def available_reservation
    errors.add(:base, 'This time is busy') if Reservation.reserved_times(start_time, end_time).where(table_number: table_number).any?
  end


end
