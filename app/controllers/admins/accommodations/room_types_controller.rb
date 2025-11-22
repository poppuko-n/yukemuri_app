class Admins::Accommodations::RoomTypesController < Admins::Accommodations::ApplicationController
  before_action :set_room_type, only: %i[show edit update destroy]
  def new
    @room_type = @accommodation.room_types.build
  end

  def create
    @room_type = @accommodation.room_types.build(room_type_params)
    if @room_type.save
      redirect_to admins_accommodation_room_type_path(@accommodation, @room_type), notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  def show; end

  def edit; end

  def update
    if @room_type.update(room_type_params)
      redirect_to admins_accommodation_room_type_path(@accommodation, @room_type), notice: t('controller.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @room_type.destroy
      redirect_to admins_root_path, notice: t('controller.destroyed')
    else
      redirect_to admins_accommodation_room_type_path(@accommodation, @room_type), alert: '予約があるため、この宿は削除できません。'
    end
  end

  private

  def set_room_type
    @room_type = @accommodation.room_types.find(params[:id])
  end

  def room_type_params
    params.require(:room_type).permit(:name, :capacity, :base_price, :image, :description, :position)
  end
end
