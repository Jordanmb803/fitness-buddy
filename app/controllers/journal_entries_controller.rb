require 'date'

class JournalEntriesController < ApplicationController
  attr_accessor :date
  def show
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @date          ||= Date.today
      @journal_entry =   JournalEntry.find_by(date: @date, user_id: current_user.id)
      @journal_entry ||= JournalEntry.create(date: Date.today, user_id: current_user.id)
      @exercises     =   Exercise.where(journal_entry_id: @journal_entry.id)
      @food_entries  =   FoodEntry.where(journal_entry_id: @journal_entry.id)
      @calorie_total =   @food_entries.sum(:calories_per_serving)
      @calorie_total ||= 0
      @daily_calorie_goal = User.find(current_user.id).daily_calorie_goal
      @daily_calorie_goal ||= 2000
      @calories_left = @daily_calorie_goal - @calorie_total
    end 
  end
  
  def destroy
    @journal_entry = JournalEntry.find(params[:id]).destroy
    
    redirect_to journal_entries_path
  end
  
  def select_date
    @date          =   params[:date]
    @journal_entry =   JournalEntry.find_by(date: @date, user_id: current_user.id)
    @journal_entry ||= JournalEntry.create(date: @date, user_id: current_user.id)
    @exercises     =   Exercise.where(journal_entry_id: @journal_entry.id)
    @food_entries  =   FoodEntry.where(journal_entry_id: @journal_entry.id)
    @calorie_total =   @food_entries.sum(:calories_per_serving)
    @calorie_total ||= 0
    @daily_calorie_goal = User.find(current_user.id).daily_calorie_goal
    @daily_calorie_goal ||= 2000
    @calories_left = @daily_calorie_goal - @calorie_total

    render "journal_entries/show"
  end
end
