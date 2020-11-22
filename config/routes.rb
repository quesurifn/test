# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'lists#index'

  resources :lists do
    resources :tasks
  end
end

