Rails.application.routes.draw do

  devise_for :user, path: "devises", controllers: {
    passwords: "devises/passwords",
    registrations: "devises/registrations",
    sessions: "devises/sessions",
  }, skip: [:sessions, :registrations]
  as :user do
    get "login", to: "devises/sessions#new", as: :new_user_session
    post "login", to: "devises/sessions#create", as: :user_session
    get "signup", to: "devises/registrations#new", as: :new_user_registration
    post "signup", to: "devises/registrations#create", as: :user_registration
    put "/signup", to: "devises/users#update"
    get "edit", to: "devises/users#edit", as: :edit_user_registration
    delete "logout", to: "devises/sessions#destroy", as: :destroy_user_session
  end

  resources :companies
  root "static_pages#index"
  resources :users
  resources :achievements
  resources :certificates, except: :index
  resources :clubs, except: %i(index show)
  resources :applies
  resources :jobs
  namespace :employers do
    resources :companies
    resources :members
  end
  resources :bookmark_likes
  resources :experiences
  resources :reward_benefits
end
