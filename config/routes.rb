Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
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

  resources :companies, except: :show
  get "/", to: "companies#show", constraints: {subdomain: /.+/}
  get "/", to: "static_pages#index", constraints: { subdomain: Settings.www }

  root "static_pages#index"


  resources :users
  resources :achievements
  resources :certificates, except: :index
  resources :clubs, except: %i(index show)
  resources :applies
  resources :jobs
  namespace :employers do
    resources :applies
    resources :jobs
    resources :users
    resources :companies
    resources :members
    resources :activities
    resources :appointments
    resources :confirm_appointments, only: :edit
    resources :templates
  end
  resources :bookmark_likes
  resources :experiences
  resources :reward_benefits
  resources :downloads
end
