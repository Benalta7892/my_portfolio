Rails.application.routes.draw do
  get 'technology_items/new'
  get 'technology_items/create'
  get 'technology_items/edit'
  get 'technology_items/update'
  get 'technology_items/destroy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'projects/index'
  get 'projects/show'
  get 'projects/new'
  get 'projects/create'
  get 'projects/edit'
  get 'projects/update'
  get 'projects/destroy'
  devise_for :users, skip: [:registrations, :passwords, :confirmations, :unlocks, :omniauth_callbacks]
  root to: "pages#home"
  get 'about', to: 'pages#about', as: :about
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
  resources :projects
  resources :resumes do
    member do
      get 'download', to: 'resumes#download_resume'
    end


    resources :educations
    resources :experiences
  end
  resources :technology_items, only: [:new, :create, :edit, :update, :destroy]
  resources :contacts, only: [:index, :show, :new, :create, :destroy]
end
