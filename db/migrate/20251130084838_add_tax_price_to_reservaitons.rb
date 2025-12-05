class AddTaxPriceToReservaitons < ActiveRecord::Migration[8.0]
  def change
    rename_column :reservations, :total_amount, :total_price
    change_column_default :reservations, :total_price, 0

    add_column :reservations, :tax_price, :integer, default: 0, null: false
    add_column :reservations, :tax_included_price, :integer, default: 0, null: false
  end
end
