class Users::Accommodations::RoomTypes::ReservationsController < Users::Accommodations::RoomTypes::ApplicationController
  before_action :build_reservation, only: %i[confirm create]
  def new
    @reservation = current_user.reservations.build
  end

  def confirm
    return redirect_to new_users_accommodation_room_type_reservation_path(@accommodation, @room_type) if request.get?

    @reservation.calculate_total_amount
    if @reservation.valid?
      render :confirm
    else
      render :new, status: :unprocessable_content
    end
  end

  def create
    @reservation.calculate_total_amount
    if @reservation.save
      redirect_to users_root_path, notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def build_reservation
    return if request.get?

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room_type = @room_type
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :night, :adult_count, :child_count, :total_amount)
  end
end