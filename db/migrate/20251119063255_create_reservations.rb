class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room_type, null: false, foreign_key: true
      t.date :check_in_date, null: false
      t.integer :night, null: false
      t.integer :adult_count
      t.integer :child_count
      t.integer :total_amount, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
