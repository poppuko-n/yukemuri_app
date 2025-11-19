class Admins::ReservationsController < Admins::ApplicationController
  before_action :set_reservation, only: %i[show edit update]
  def index
    @reservations = Reservation.includes(:user, room_type: :accommodation).default_order
  end

  def show; end

  def edit; end

  def update
    if @reservation.update_with_room_inventory(reservation_params)
      redirect_to admins_reservations_path, notice: t('controller.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:status)
  end
end
