Rails.application.routes.draw do
  devise_for :users
  
  root to: 'homes#top'
  resources :books
  resources :users
  
  get '/home/about' => 'homes#about', as: 'about'
end
