Rails.application.routes.draw do

  mount Ckeditor::Engine => "/ckeditor"
  mount ActionCable.server => "/cable"
  devise_for :user, path: "devises", controllers: {
    passwords: "devises/passwords",
    registrations: "devises/registrations",
    sessions: "devises/sessions",
    confirmations: "devises/confirmations",
    omniauth_callbacks: "devises/omniauth_callbacks"
  }, skip: [:sessions, :registrations]
  as :user do
    post "login", to: "devises/sessions#create", as: :user_session
    post "signup", to: "devises/registrations#create", as: :user_registration
    put "/signup", to: "devises/users#update"
    get "edit", to: "devises/users#edit", as: :edit_user_registration
    delete "logout", to: "devises/sessions#destroy", as: :destroy_user_session
  end

  resources :companies, except: :show
  get "/", to: "companies#show", constraints: {subdomain: /.+/}
  get "/", to: "static_pages#index", constraints: { subdomain: Settings.www }
  get "/see_all_notify", to: "notifications#update"

  root "static_pages#index"
  resources :set_language, only: :index
  resources :users
  resources :achievements
  resources :certificates, except: :index
  resources :clubs, except: %i(index show)
  resources :applies
  resources :jobs
  namespace :employers do
    resources :send_emails
    resources :jobs do
      resources :applies, only: %i(show index update)
    end
    resources :users
    resources :companies do
      resources :candidates, except: %i(edit destroy update)
      get "/search_job", to: "candidates#search_job"
    end
    resources :members
    resources :company_activities
    resources :appointments
    resources :confirm_appointments, only: :edit
    resources :templates
    resources :applies do
      resources :notes
    end
    resources :dashboards
    resources :apply_statuses
    resources :histories
    resources :email_sents
    resources :steps
    resources :status_steps, only: :index
    resources :questions, only: :index
  end
  resources :bookmark_likes
  resources :experiences
  resources :reward_benefits
  resources :downloads
  resources :notifications, only: :index
end
