class Users::Accommodations::RoomTypes::ReservationsController < Users::Accommodations::RoomTypes::ApplicationController

  def new
    @reservation = current_user.reservations.new
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :night, :adult_count, :child_count, :total_amount)
  end
end