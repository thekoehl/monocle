ComPhantomdataMonicle::Application.routes.draw do
  
  resources :alarms
  
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
