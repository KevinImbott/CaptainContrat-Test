# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#index'

  # root 'persos#index'

  resources :champions, only: %i[index create show update destroy]
end
