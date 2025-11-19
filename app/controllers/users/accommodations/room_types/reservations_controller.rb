class Users::Accommodations::RoomTypes::ReservationsController < Users::Accommodations::RoomTypes::ApplicationController
  before_action :build_reservation, only: %i[confirm]
  def new
    @reservation = current_user.reservations.build
  end

  def confirm
    if @reservation.valid?
      render :confirm
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def build_reservation
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room_type = @room_type
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :night, :adult_count, :child_count, :total_amount)
  end
end