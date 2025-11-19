class Users::ReservationsController < Users::ApplicationController
  before_action :set_reservation, only: %i[show update]
  def index
    @reservations = current_user.reservations.includes(room_type: :accommodation)
  end

  def show; end

  def update
    @reservation.cancel!
    redirect_to users_reservation_path(@reservation), notice: '予約をキャンセルしました。'
  rescue => e
    redirect_to users_reservation_path(@reservation), alert: 'キャンセルできません。'
  end


  private

  def set_reservation
    @reservation = current_user.reservations.includes(room_type: :accommodation).find(params[:id])
  end
end
