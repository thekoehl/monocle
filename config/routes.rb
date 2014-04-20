Rails.application.routes.draw do
  devise_for :users
  namespace :api, :path => 'api' do
    resources :data_points
    resources :sensors
  end
  resources :sensors
  match 'dashboard', to: 'dashboard#index', via: [:get]
  match 'installation', to: 'users#installation', via: [:get]
  root 'static_pages#landing_page'
end
