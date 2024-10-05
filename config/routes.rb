# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    get 'authors', to: 'authors#index'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'authors#index'
end
