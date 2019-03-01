class UsersController < ApplicationController
  def show
  end

  def index
  end

  def edit
  end

  def edit_goals
    @user = User.find(current_user.id)
  end

  def update_goals
    @user = User.find(current_user.id)
    @user.update(goals_params)
    @user.save

    redirect_to menu_show_path
  end

  private
  def goals_params
    params.require(:user).permit(:starting_weight_in_lbs, :current_weight_in_lbs, :goal_weight_in_lbs, :weekly_goal_weight_loss_in_lbs, :activity_level)
  end
end
