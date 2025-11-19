class Admins::ReservationsController < Admins::ApplicationController
  before_action :set_reservation, only: %i[show]
  def index
    @reservations = Reservation.includes(:user, room_type: :accommodation).default_order
  end

  def show; end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
