# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :v1 do
    resources :authors, only: %i[index] do
      get 'publications', to: 'publications#index_for_author', on: :member
    end

    resources :publications
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'v1/publications#index'
end
