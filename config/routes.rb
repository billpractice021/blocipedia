Rails.application.routes.draw do
  devise_for :users
  
  get 'about', to: 'welcome#about'

  root 'welcome#index'

end
