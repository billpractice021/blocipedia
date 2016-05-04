Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  
  get 'about', to: 'welcome#about'

  root 'welcome#index'

end
