class ChangeDailyCalorieGoalInUsers < ActiveRecord::Migration
  def change
    change_column :users, :daily_calorie_goal, :integer, default: 2000
  end
end
