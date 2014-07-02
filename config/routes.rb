Rails.application.routes.draw do
  devise_for :users

  resources :gadgets do
    resources :images
  end

  root 'gadgets#index'
end
