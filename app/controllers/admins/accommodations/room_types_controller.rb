class Admins::Accommodations::RoomTypesController < Admins::Accommodations::ApplicationController
  def new
    @room_type = @accommodation.room_types.build
  end

  def create
    @room_type = @accommodation.room_types.build(room_type_params)
    if @room_type.save
      redirect_to admins_accommodation_room_types_path(@room_type), notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def room_type_params
    params.require(:room_type).permit(:name, :capacity, :base_price, :image, :description, :position)
  end
end
