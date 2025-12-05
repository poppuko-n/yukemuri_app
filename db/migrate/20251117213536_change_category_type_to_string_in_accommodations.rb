class ChangeCategoryTypeToStringInAccommodations < ActiveRecord::Migration[8.0]
  def change
    change_column :accommodations, :category, :string
  end
end
