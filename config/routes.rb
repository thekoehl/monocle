ComPhantomdataMonicle::Application.routes.draw do

  resources :camera_events
  resources :cameras
  resources :comparisons

  resources :alarms do
    member do
      post :reset
    end
  end

  resources :data_points
  get 'dashboard', to: 'sensors#dashboard', as: :dashboard

  resources :sensors do
    member do
      get :big_display
      get :data
      get :data_points
    end
  end

  namespace :api, :path => 'api' do
    resources :sensors
  end

  devise_for :users

  # Static Pages
  match 'pages/home' => "pages#home", :as=>"home"

  root :to => 'pages#home'
end
