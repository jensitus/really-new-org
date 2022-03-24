Rails.application.routes.draw do
  get 'photos/destroy'
  get 'photos/show'
  resources :microposts
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "microposts#index"
end
