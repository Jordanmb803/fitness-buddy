class AddNameToFoodEntries < ActiveRecord::Migration
  def change
    add_column :food_entries, :name, :string
  end
end
