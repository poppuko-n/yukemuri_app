class Admins::ReservationsController < Admins::ApplicationController
  def index
    @reservations = Reservation.includes(:user, room_type: :accommodation).default_order
  end
end
