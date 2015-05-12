class ReservationsController < ApplicationController
  respond_to :json

  # @return [Array<Reservation>] all reservations
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors.full_messages
    end
  end

  private

  # @return [Array<String>] permitted params attributes
  def reservation_params
    params.permit(:table_number, :start_time, :end_time)
  end
end
