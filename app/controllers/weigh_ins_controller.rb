class WeighInsController < ApplicationController
  attr_accessor :weight_in_lbs, :date
  def show
    
  end

  def index
  end

  def edit
  end

  def new
    @weigh_in = WeighIn.new(user_id: current_user.id, date: params[:date])
  end

  def create
    @weigh_in = WeighIn.create(user_id: current_user.id, date: params[:date], weight_in_lbs: weigh_in_params[:weight_in_lbs])

    redirect_to select_date_path(date: @weigh_in.date)
  end

  private

  def weigh_in_params
    params.require(:weigh_in).permit(:weight_in_lbs, :date)
  end
end
