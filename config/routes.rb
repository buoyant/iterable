Rails.application.routes.draw do
  get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  # Defines the root path route ("/")
  root "home#index"

  post '/events/:id', to: 'home#create_event', as: 'create_event'

  get '/events', to: 'home#events', as: 'events'
  get '/emails', to: 'home#emails', as: 'emails'

end
