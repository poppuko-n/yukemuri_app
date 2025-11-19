class Users::ReservationsController < Users::ApplicationController
  def index
    @reservations = current_user.reservations
  end
end
