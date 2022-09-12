Rails.application.routes.draw do
  # get 'description/new'
  # get 'description/create'
  # get 'description/update'
  # get 'description/delete'
  # get 'items/new'
  # get 'items/create'
  # get 'items/update'
  # get 'items/delete'
  # items :todos
  resources :todos do
    resources :items do
      resources :description
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :photo_galleries, path: 'galleries'

  get 'photos/destroy'
  get 'photos/show/:id', to: 'photos#show', as: 'photo'
  resources :microposts, path: 'post' do
    resources :comments, as: 'comments'
  end
  get '/microposts/:limit/:offset', to: 'microposts#index' , as: 'home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'microposts#index'
  # get 'users/index'
  get ':name', to: 'users#show', as: 'user'

end
