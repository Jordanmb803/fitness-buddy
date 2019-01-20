class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :jounal_entry_id
      t.string :exercise
      t.integer :weight_in_lbs
      t.integer :reps
      t.integer :sets

      t.timestamps null: false
    end
  end
end
