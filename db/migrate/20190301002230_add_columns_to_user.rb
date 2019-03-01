class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :starting_weight_in_lbs, :integer
    add_column :users, :current_weight_in_lbs, :integer
    add_column :users, :goal_weight_in_lbs, :integer
    add_column :users, :weekly_goal_weight_loss_in_lbs, :integer
    add_column :users, :activity_level, :string
  end
end
