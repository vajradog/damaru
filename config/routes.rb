Rails.application.routes.draw do

  root 'posts#index'
  resources :posts, only: [:index, :show]

  get "register", to: "admin/users#new"
  get "sign_in", to: "sessions#new"
  get "sign_out", to: "sessions#destroy"

  resources :sessions, only: [:create]
  resources :dashboards, only: [:index]
  resources :pages, only: [:show]

  namespace :admin do
    resources :posts
    resources :users
    resources :general_settings, only: [:edit, :update]
    resources :pages, except: [:show] do
      put :sort, on: :collection
    end
  end
end
