require 'date'

class JournalEntriesController < ApplicationController
  def show
    @journal_entry      = JournalEntry.find(params[:id])
    @exercises          = Exercise.where(journal_entry_id: @journal_entry.id)
    @weigh_in           = WeighIn.find_by(date: @journal_entry.date, user_id: current_user.id)
    puts "Weigh in: #{@weigh_in} ****************"
    @food_entries       = FoodEntry.where(journal_entry_id: @journal_entry.id)
    @calorie_total      = calorie_total(@food_entries)
    @daily_calorie_goal = daily_calorie_goal
    @calories_left      = @daily_calorie_goal - @calorie_total
  end

  def select_date
    if current_user.nil?
      redirect_to new_user_session_path
    else
      date = params[:date]
      date ||= Date.today

      redirect_to journal_entry_path(
        find_or_create_journal_entry(date))
    end
  end

  private

  def find_or_create_journal_entry date
    journal_entry = JournalEntry.find_by(date: date, user_id: current_user.id)
    journal_entry ||= JournalEntry.create(date: date, user_id: current_user.id)
  end

  def calorie_total food_entries
    calorie_total = food_entries.sum(:calories_per_serving)
    calorie_total ||= 0
  end

  def daily_calorie_goal
    daily_calorie_goal = User.find(current_user.id).daily_calorie_goal
  end
end
