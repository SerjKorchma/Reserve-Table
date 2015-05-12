class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :table_number, :start_time, :end_time

  def start_time
    object.start_time.strftime('%Y-%m-%dT%H:%M:%S')
  end

  def end_time
    object.end_time.strftime('%Y-%m-%dT%H:%M:%S')
  end

end