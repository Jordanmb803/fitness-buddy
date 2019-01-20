require 'date'

class JournalEntriesController < ApplicationController
  attr_accessor :date
  def show
    @date ||= Date.today
    @journal_entry = JournalEntry.find_by(date: @date)
    @journal_entry ||= JournalEntry.create(date: Date.today)
    @exercises = Exercise.where(journal_entry_id: @journal_entry.id)
  end

  def destroy
    @journal_entry = JournalEntry.find(params[:id]).destroy

    redirect_to journal_entries_path
  end

  def select_date
    @date = params[:date]
    @journal_entry = JournalEntry.find_by(date: @date)
    @journal_entry ||= JournalEntry.create(date: @date)
    @exercises = Exercise.where(journal_entry_id: @journal_entry.id)

    render "journal_entries/show"
  end
end
