class CreateAccommodations < ActiveRecord::Migration[8.0]
  def change
    create_table :accommodations do |t|
      t.integer :prefecture, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.integer :category, null: false
      t.text :description, null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end
    add_index :accommodations, [:name, :address], unique: true
  end
end
