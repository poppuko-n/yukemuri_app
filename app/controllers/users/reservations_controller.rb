class Users::ReservationsController < Users::ApplicationController
  before_action :set_reservation, only: %i[show]
  def index
    @reservations = current_user.reservations
  end

  def show; end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end
end
