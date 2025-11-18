class CreateRoomTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :room_types do |t|
      t.references :accommodation, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :capacity, null: false
      t.integer :base_price, null: false
      t.text :description, null: false
      t.integer :position

      t.timestamps
    end

    add_index :room_types, [:accommodation_id, :name], unique: true
  end
end
