Rails.application.routes.draw do
  resources :photo_galleries

  get 'photos/destroy'
  get 'photos/show'
  resources :microposts do
    resources :comments
  end
  get '/microposts/:limit/:offset', to: 'microposts#index' , as: 'home'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'microposts#index'
end
