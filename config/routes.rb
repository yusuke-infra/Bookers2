Rails.application.routes.draw do
  devise_for :users
  
  root to: 'homes#top'
  resources :books do
    resource :favorite, only: [:create, :destroy]
  end
  
  resources :users
  
  get '/home/about' => 'homes#about', as: 'about'
end
