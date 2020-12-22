Rails.application.routes.draw do
  
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get 'home', to: 'home#index'
  post 'send_email', to: 'home#send_email'

  get 'dashboard', to: 'dashboard#index'
  get 'schedule', to: 'dashboard#schedule'
  get 'employees', to: 'dashboard#employees'
  get 'employee/:id', to: 'dashboard#show_employee', as: 'employee'
  get 'employee/:id/calendar', to: 'dashboard#employee_calendar', as: 'employee_calendar'
  get 'employee/:id/punches', to: 'dashboard#employee_punches', as: 'employee_punches'

  patch 'clock_in', to: 'punch#clock_in'
  patch 'clock_out', to: 'punch#clock_out'
  get 'employee/:id/punches/:punch_id/edit', to: 'punch#edit', as: 'edit_punch'
  patch 'employee/:id/punches/:punch_id', to: 'punch#update', as: 'update_punch'

  root 'home#index'
end
