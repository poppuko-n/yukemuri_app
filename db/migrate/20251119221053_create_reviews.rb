class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment, null: false

      t.timestamps
    end
    add_index :reviews, [:user_id, :reservation_id], unique: true
  end
end
