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
  get 'employee/:id/shifts', to: 'dashboard#employee_shifts', as: 'employee_shifts'

  patch 'clock_in', to: 'punch#clock_in'
  patch 'clock_out', to: 'punch#clock_out'
  get 'employee/:id/punches/:punch_id/edit', to: 'punch#edit', as: 'edit_punch'
  patch 'employee/:id/punches/:punch_id', to: 'punch#update', as: 'update_punch'
  delete 'employee/:id/punches/:punch_id', to: 'punch#destroy', as: 'delete_punch'
  get 'employee/:id/punches/new', to: 'punch#new', as: 'new_punch'
  post 'employee/:id/punches/create', to: 'punch#create', as: 'create_punch'

  get 'employee/:id/shifts/:shift_id/edit', to: 'shift#edit', as: 'edit_shift'
  patch 'employee/:id/shifts/:shift_id', to: 'shift#update', as: 'update_shift'
  delete 'employee/:id/shifts/:shift_id', to: 'shift#destroy', as: 'delete_shift'
  get 'employee/:id/shifts/new', to: 'shift#new', as: 'new_shift'
  post 'employee/:id/shifts/create', to: 'shift#create', as: 'create_shift'

  root 'home#index'
end
