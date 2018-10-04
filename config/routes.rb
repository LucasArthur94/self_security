Rails.application.routes.draw do
  devise_for :users

  resources :devices
  resources :users

  get '/', to: 'home#index', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
