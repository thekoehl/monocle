Rails.application.routes.draw do
  devise_for :users
  resources :dashboards
  namespace :api, :path => 'api' do
    resources :data_points
    resources :sensors
  end

  match 'installation', to: 'users#installation', via: [:get]
  root 'static_pages#landing_page'
end
