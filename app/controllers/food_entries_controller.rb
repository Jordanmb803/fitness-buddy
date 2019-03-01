class FoodEntriesController < ApplicationController
  def show
  end

  def new
    @food_entry = FoodEntry.new(date: params[:date])
    @journal_entry = JournalEntry.find(params[:journal_entry_id])
  end

  def create
    @food_entry = FoodEntry.create(food_entry_params)
    @food_entry.update(journal_entry_id: params[:journal_entry_id])
    @food_entry.save
    @journal_entry = JournalEntry.find(params[:journal_entry_id])

    redirect_to select_date_path(date: @journal_entry.date)
  end

  def edit
    @food_entry = FoodEntry.find(params[:id])
  end

  def update
    @food_entry = FoodEntry.find(params[:id])
    @food_entry.update(food_entry_params)
    @food_entry.save

    redirect_to select_date_path(date: @food_entry.date)
  end

  def index
  end
  
  def destroy
    @food_entry = FoodEntry.find(params[:id])
    @date = @food_entry.date
    @food_entry.destroy

    redirect_to select_date_path(date: @date)
  end

  private
  def food_entry_params
    params.require(:food_entry).permit(:calories_per_serving, :protien_per_servings, :carbohydrates_per_serving, :fat_per_serving, :sugar_per_serving, :servings, :date)
  end
end
