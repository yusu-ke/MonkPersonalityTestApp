Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine => "/avo"
  end
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root to: "home#index"
  get "contact", to: "home#contact"
  get "terms", to: "home#terms"
  get "privacy", to: "home#privacy"

  resources :personality_tests, only: [ :new, :create, :show ]
  resources :posts, only: [ :index, :new, :create, :edit, :show, :edit, :update, :destroy ]
  resource :profile, only: [ :show, :edit, :update ] do
    collection do
      get :user_info
    end
  end

  # resources :posts do
  #  resources :post_images, :only => [:create, :destroy]
  # end
end
