Rails.application.routes.draw do
  get 'home/index'
  post 'home_controller/send_email', to: 'home#send_email'
  root 'home#index'
end
