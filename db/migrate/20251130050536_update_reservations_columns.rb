class UpdateReservationsColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :reservations, :night, :night_count

    change_column_null :reservations, :adult_count, false
    change_column_null :reservations, :child_count, false
  end
end
