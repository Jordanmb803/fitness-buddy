class AddDateToFoodEntries < ActiveRecord::Migration
  def change
    add_column :food_entries, :date, :date
  end
end
