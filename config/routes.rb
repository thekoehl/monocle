PDMonocle::Application.routes.draw do
  resources :alarms
  resources :cameras
  resources :sensors

  namespace :api, :path => 'api' do
    resources :alarms
    resources :cameras
    resources :camera_events do
    	collection do
    		post 'destroy_all'
    	end
    end
    resources :data_points
    resources :sensors
    get '/data-points/create', to: 'data_points#create'
  end

  devise_for :users
  root 'static_pages#home'
end
