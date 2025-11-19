class Users::Reservations::ApplicationController < Users::ApplicationController
  before_action :set_reservation

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:reservation_id])
  end
end