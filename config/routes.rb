Rails.application.routes.draw do
  get 'shows/index'
  get 'bookings/new'
  devise_for :users
  resources :movies do
    resources :shows
  end

  resources :bookings do
    resources :payments
  end


  resources :cinemas do 
    resources :screens do 
      resources :shows do
        resources :seats
        resources :bookings
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
