Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show]

  resources :charges, only: [:create, :destroy]

  resources :wikis
  
  authenticated :user do
  	root "wikis#index", as: :authenticated_root
  end
  
  get 'about', to: 'welcome#about'

  root 'welcome#index'

end
