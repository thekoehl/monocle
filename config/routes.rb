PDMonocle::Application.routes.draw do
  resources :data_points
  resources :sensors

  namespace :api, :path => 'api' do
    resources :data_points
    resources :sensors
    get '/data-points/create', to: 'data_points#create'
    get '/sensors/destroy', to: 'sensors#destroy'
  end

  devise_for :users
  root 'static_pages#home'
end
