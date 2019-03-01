require 'date'

class ExercisesController < ApplicationController
  attr_accessor :journal_entry_id, :date, :exercise
  def index
  end

  def show
  end

  def search
    @journal_entry = JournalEntry.find(params[:journal_entry_id])
    @exercise      = Exercise.new(user_id: current_user.id)
    @date          = params[:date]
  end

  def new
    @last_session  = Exercise.where(exercise: params[:exercise], user_id: current_user.id).last
    @exercise      = Exercise.where(exercise: params[:exercise], user_id: current_user.id).last
    @exercise      ||= Exercise.new(exercise: params[:exercise], user_id: current_user.id)
    @exercise.date = params[:date]
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    @exercise.update(exercise_params)
    @exercise.save
    @journal_entry = JournalEntry.find_by(date: @exercise.date, user_id: current_user.id)
    @exercise.update(journal_entry_id: @journal_entry.id)
    @exercise.save

    redirect_to journal_entry_path(@journal_entry)
  end

  def create
    @exercise = Exercise.create(exercise_params)
    @exercise.save
    @journal_entry = JournalEntry.find_by(date: @exercise.date, user_id: current_user.id)
    @exercise.update(journal_entry_id: @journal_entry.id, user_id: current_user.id)
    @exercise.save

    redirect_to select_date_path(date: @journal_entry.date)
  end

  def destroy
    @exercise      = Exercise.find(params[:id])
    @journal_entry = JournalEntry.find(@exercise.journal_entry_id)
    @exercise.destroy

    redirect_to select_date_path(date: @journal_entry.date)
  end

  private
  def exercise_params
    params.require(:exercise).permit(:date, :exercise, :weight_in_lbs, :reps, :sets, :notes)
  end
end
