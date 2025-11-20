class Admins::Accommodations::RoomTypes::RoomInventoriesController < Admins::Accommodations::RoomTypes::ApplicationController
  before_action :set_room_inventory, only: %i[edit update]
  def new
    @room_inventory = @room_type.room_inventories.build
  end

  def create
    @room_inventory = @room_type.room_inventories.build(room_inventory_params)

    if @room_inventory.save
      redirect_to admins_accommodation_room_type_path(@accommodation, @room_type), notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit; end

  def update
    if @room_inventory.update(update_room_inventory_params)
      redirect_to admins_accommodation_room_type_path(@accommodation, @room_type), notice: t('controller.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_room_inventory
    @room_inventory = @room_type.room_inventories.find(params[:id])
  end

  def room_inventory_params
    params.require(:room_inventory).permit(:date, :remaining_room)
  end

  def update_room_inventory_params
    params.require(:room_inventory).permit(:remaining_room)
  end
end
