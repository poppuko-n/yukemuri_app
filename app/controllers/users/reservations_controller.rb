class Users::ReservationsController < Users::ApplicationController
  before_action :set_reservation, only: %i[show update]
  def index
    @reservations = current_user.reservations.includes(room_type: :accommodation).default_order
  end

  def show; end

  def update
    if @reservation.cancel
      redirect_to users_reservation_path(@reservation), notice: t('reservations.cancelled')
    else
      redirect_to users_reservation_path(@reservation), alert: t('reservations.cannot_cancel')
    end
  end

  private

  def set_reservation
    @reservation = current_user.reservations.includes(room_type: :accommodation).find(params[:id])
  end
end
