Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :photo_galleries

  get 'photos/destroy'
  get 'photos/show'
  resources :microposts do
    resources :comments
  end
  get '/microposts/:limit/:offset', to: 'microposts#index' , as: 'home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'microposts#index'
end
