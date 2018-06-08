Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'home#index'

  # get '/tours' => "tours#index", as: :user_root

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tours do
    resources :locations
    resources :bookings do
      resources :reviews, only: [:new, :create, :show, :destroy]
    end
    member do
      post :change_status
    end
  end

  resources :dashboard, only: :index
end

# dashboard
# messages
