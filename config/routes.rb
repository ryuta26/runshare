Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'graphs/:id', to: 'users#graph',as: 'graphs'
  resources :users, only: [:index, :show, :new, :create]
  resources :records, only: [:create, :destroy, :update, :edit]
end
