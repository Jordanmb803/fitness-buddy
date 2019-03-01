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

    render "journal_entries/show"
  end
end
