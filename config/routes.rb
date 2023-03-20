Rails.application.routes.draw do
  root 'pages#about', as: 'home'
  resource :session, only: %i[new create destroy]
  resources :users do
    member do
      get :confirm_email
    end
  end
  post 'users/create'
  get 'pages/watch'
  get 'sessions/new', as: 'login'
end
