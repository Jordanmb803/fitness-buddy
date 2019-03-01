class CreateFoodEntries < ActiveRecord::Migration
  def change
    create_table :food_entries do |t|
      t.integer :servings
      t.integer :calories_per_serving
      t.integer :protien_per_servings
      t.integer :carbohydrates_per_serving
      t.integer :fat_per_serving
      t.integer :sugar_per_serving
      t.integer :user_id
      t.integer :journal_entry_id

      t.timestamps null: false
    end
  end
end
