class Admins::Accommodations::RoomTypesController < Admins::Accommodations::ApplicationController
  before_action :set_room_type, only: %i[show destroy]
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

  def show; end

  def destroy
    @room_type.destroy!
    redirect_to admins_root_path, notice: t('controller.destroyed')
  end

  private

  def set_room_type
    @room_type = @accommodation.room_types.find(params[:id])
  end

  def room_type_params
    params.require(:room_type).permit(:name, :capacity, :base_price, :image, :description, :position)
  end
end
