require 'date'

class ExercisesController < ApplicationController
  attr_accessor :journal_entry_id, :date, :exercise
  def index
  end

  def show
  end

  def search
    @journal_entry = JournalEntry.find(params[:journal_entry_id])
    @exercise = Exercise.new
  end

  def new
    @last_session = Exercise.where(exercise: params[:exercise]).last
    puts "last session: #{@last_session.exercise} #{@last_session.weight_in_lbs} #{@last_session.sets} #{@last_session.reps} *****************"
    @exercise = Exercise.find_by(exercise: params[:exercise])
    @exercise ||= Exercise.new
  end

  def update
    @exercise = Exercise.find(params[:id])
    @exercise.update(exercise_params)
    @exercise.save
    @journal_entry = JournalEntry.find_by(date: @exercise.date)
    @exercise.update(journal_entry_id: @journal_entry.id)
    @exercise.save

    redirect_to journal_entry_path(@journal_entry)
  end

  def create
    @exercise = Exercise.create(exercise_params)
    @exercise.save
    @journal_entry = JournalEntry.find_by(date: @exercise.date)
    @exercise.update(journal_entry_id: @journal_entry.id)
    @exercise.save

    redirect_to journal_entry_path(@journal_entry)
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @journal_entry = JournalEntry.find(@exercise.journal_entry_id)
    @exercise.destroy

    redirect_to journal_entries_show_path(@journal_entry)
  end

  private
  def exercise_params
    params.require(:exercise).permit(:date, :exercise, :weight_in_lbs, :reps, :sets, :notes)
  end
end
