ComPhantomdataMonicle::Application.routes.draw do
  
  resources :reporting_dashboards


  resources :alarms do
    member do
      post :reset
    end
  end
  
  resources :data_points
  
  resources :sensors do
    collection do
      get :dashboard
    end
    member do      
      get :big_display
      get :data
      get :data_points
    end
  end


  devise_for :users

  # Static Pages
  match 'pages/home' => "pages#home", :as=>"home"

  root :to => 'pages#home'
end
