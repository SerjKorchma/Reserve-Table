require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context 'validation' do
    let(:reservation) { build(:reservation) }

    it { should validate_presence_of(:table_number) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it 'should be valid when #table_number is 6' do
      reservation.table_number = 6
      expect(reservation).to be_valid
    end

    it 'should be not valid when #table_number less than 1' do
      reservation.table_number = 0
      expect(reservation).not_to be_valid
    end

    it 'should be not valid when #table_number greater than 12' do
      reservation.table_number = 13
      expect(reservation).not_to be_valid
    end

    context 'reservation time' do

      it 'should not be valid when start time less then end time' do
        reservation.start_time = 2.hour.from_now
        reservation.end_time = 1.hour.from_now
        expect(reservation).not_to be_valid
      end

      it 'should not be valid when start time less then current time' do
        reservation.start_time = 2.hour.ago
        expect(reservation).not_to be_valid
      end

      let(:reservation) { create(:reservation) }
      let(:second_reservation) {build(:reservation)}

      it 'should not be valid when table is reserved at the same time' do
        second_reservation.start_time = reservation.start_time
        second_reservation.end_time = reservation.end_time
        expect(second_reservation).not_to be_valid
      end

      it 'should not be valid when table is reserved' do
        second_reservation.start_time = reservation.start_time + 10.minutes
        second_reservation.end_time = reservation.end_time - 10.minutes
        expect(second_reservation).not_to be_valid
      end

      it 'should be valid when table reserved at free time' do
        second_reservation.start_time = reservation.end_time + 1.hour
        second_reservation.end_time = reservation.end_time + 3.hour
        expect(second_reservation).to be_valid
      end
    end
  end
end
