# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  resources :books, only: [:index, :show]
end
