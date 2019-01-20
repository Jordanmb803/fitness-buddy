require 'date'

class ExercisesController < ApplicationController
  attr_accessor :journal_entry_id, :date

  def initialize
  end

  def index
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.save
    @journal_entry = JournalEntry.find_by(date: @exercise.date)
    @exercise.update(journal_entry_id: @journal_entry.id)
    @exercise.save

    redirect_to journal_entries_show_path(@journal_entry)
  end

  private
  def exercise_params
    params.require(:exercise).permit(:date, :exercise, :weight_in_lbs, :reps, :sets, :notes)
  end
end
