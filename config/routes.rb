Rails.application.routes.draw do
  get 'menu/show'

  devise_for :users
  get 'exercises/index'

  get 'exercises/show'

  post 'exercises/new'

  get 'journal_entries/show'

  get 'select_date', to: 'journal_entries#select_date', as: :select_date

  get 'search', to: 'exercises#search', as: :exercise_search

  get 'edit_goals/:id', to: 'users#edit_goals', as: :edit_goals

  put 'update_goals/:id', to: 'users#update_goals', as: :update_goals

  resources :exercises, :journal_entries, :exercise, :food_entries, :users

  root 'journal_entries#select_date'

end
