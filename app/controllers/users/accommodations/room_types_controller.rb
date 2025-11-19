class Users::Accommodations::RoomTypesController < Users::Accommodations::ApplicationController
  before_action :set_room_type, only: %i[show]

  def show; end

  private

  def set_room_type
    @room_type = @accommodation.room_types.find(params[:id])
  end
end
