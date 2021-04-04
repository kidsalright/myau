Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index', as: 'home'
  resources :posts do
    get :like, on: :member
  end
end
