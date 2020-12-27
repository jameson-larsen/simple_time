Rails.application.routes.draw do
  
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get 'home', to: 'home#index'
  post 'send_email', to: 'home#send_email'

  get 'dashboard', to: 'dashboard#index'
  get 'schedule', to: 'dashboard#schedule'
  get 'request_time_off', to: 'dashboard#req_time'
  post 'request_time_off/create', to: 'dashboard#create_req_time', as: 'create_request'
  get 'employees', to: 'dashboard#employees'
  get 'employee/:id', to: 'dashboard#show_employee', as: 'employee'
  get 'employee/:id/calendar', to: 'dashboard#employee_calendar', as: 'employee_calendar'
  get 'employee/:id/punches', to: 'dashboard#employee_punches', as: 'employee_punches'
  get 'employee/:id/shifts', to: 'dashboard#employee_shifts', as: 'employee_shifts'
  get 'time_off_requests', to: 'dashboard#view_requests', as: 'view_requests'

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

  patch 'time_off_request/:request_id/accept', to: 'time_off_request#accept', as: 'accept_request'
  patch 'time_off_request/:request_id/deny', to: 'time_off_request#deny', as: 'deny_request'

  get 'admin/register_new_user', to: 'employee#admin_new_user', as: 'admin_new_user'
  post 'admin/register_new_user/create', to: 'employee#admin_create_user', as: 'admin_create_user'
  delete 'admin/delete_user/:id', to: 'employee#admin_delete_user', as: 'admin_delete_user'

  get 'new_user/register/:registration_token', to: 'employee#new_user', as: 'new_user'
  post 'new_user/register/:registration_token/create', to: 'employee#create_user', as: 'create_user'

  root 'home#index'
end
