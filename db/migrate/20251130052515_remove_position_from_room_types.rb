class RemovePositionFromRoomTypes < ActiveRecord::Migration[8.0]
  def change
    remove_column :room_types, :position, :integer

    remove_index :room_types, name: 'index_room_types_on_accommodation_id'
  end
end
