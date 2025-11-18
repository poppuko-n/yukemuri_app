class Admins::Accommodations::RoomTypes::RoomInventoriesController < Admins::Accommodations::RoomTypes::ApplicationController
  def new
    @room_inventory = @room_type.room_inventories.build
  end

  def create
    @room_inventory = @room_type.room_inventories.build(room_inventory_params)

    if @room_inventory.save
      redirect_to admins_root_path, notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end

  end

  private

  def room_inventory_params
    params.require(:room_inventory).permit(:date, :remaining_room)
  end
end
