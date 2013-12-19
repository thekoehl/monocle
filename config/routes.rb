PDMonocle::Application.routes.draw do
  resources :alarms, except: [:show]
  resources :cameras, only: [:index]
  resources :camera_events, only: [:index] do
    collection do
      post 'destroy_all'
    end
  end
  resources :sensors, only: [:show, :index] do
    collection do
      get 'scifi'
    end
  end
  resources :stateful_sensors, only: [:index]

  namespace :api, :path => 'api' do
    resources :alarms, only: [:create, :index]
    resources :cameras, only: [:create, :index]
    resources :camera_events, only: [:create, :index] do
    	collection do
    		post 'destroy_all'
    	end
    end
    resources :data_points, only: [:create]
    resources :sensors, only: [:destroy, :index]

    resources :state_changes, only: [:create]
    get '/data-points/create', to: 'data_points#create'
    get '/state-changes/create', to: 'state_changes#create'
  end

  devise_for :users
  root 'static_pages#home'
end
