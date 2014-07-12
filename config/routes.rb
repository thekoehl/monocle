Rails.application.routes.draw do
  devise_for :users
  namespace :api, :path => 'api' do
    resources :cameras
    resources :data_points
    resources :sensors
  end
  resources :cameras
  resources :groups
  resources :sensors
  match 'installation', to: 'users#installation', via: [:get]
  root 'static_pages#landing_page'
end
