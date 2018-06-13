Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'home#index'
  get '/user-landing-page', to: 'home#user'
  get '/play', to: 'play#index'
  get '/play/1', to: 'play#first'
  get '/play/2', to: 'play#second'
  get '/play/3', to: 'play#third'
  get '/play/final', to: 'play#final'
  get '/play/scoreboard', to: 'play#scoreboard'
  # get '/tours' => "tours#index", as: :user_root

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tours do
    resources :locations
    resources :bookings do
      resources :reviews, only: [:new, :create, :show, :update, :destroy]
    end
    member do
      post :change_status
    end
  end

  get '/my-tours', to: 'dashboard#my_tours'
  get '/my-bookings', to: 'dashboard#my_bookings'

end

# dashboard
# messages
