Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index', as: 'home'
  resources :users
  resources :user
  resources :posts do
    get :like, on: :member
  end
end
