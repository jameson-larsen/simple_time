Rails.application.routes.draw do
  
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get 'home', to: 'home#index'
  post 'send_email', to: 'home#send_email'

  get 'dashboard', to: 'dashboard#index'

  patch 'clock_in', to: 'punch#clock_in'
  patch 'clock_out', to: 'punch#clock_out'

  root 'home#index'
end
