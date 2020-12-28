class DashboardController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?, only: [:employees, :show_employee, :employee_calendar, :employee_punches, :employee_shifts, :view_requests]
    before_action :set_vars
    before_action :same_company?, only: [:show_employee, :employee_calendar, :employee_punches, :employee_shifts]

    def index
        if current_user.p_unchanged?
            redirect_to first_login_password_path
        else
            @punches = current_user.punches
        end
    end

    def schedule
        @shifts = current_user.shifts
        @punches = current_user.punches
        @to = current_user.time_off_requests.where(status:2)
    end

    def employees
        @admin = current_user
        @employees = @company.users.search(params[:search]).order('l_name ASC')
        @link = Company.find(current_user.company_id).registration_token
    end

    def show_employee
        @employee = User.find(params[:id])
        @hours_between = @employee.hours_between(params[:date1],params[:date2])
    end

    def employee_calendar
        @employee = User.find(params[:id])
        @shifts = @employee.shifts
        @punches = @employee.punches
        @to = @employee.time_off_requests.where(status:2)
    end

    def employee_punches
        @employee = User.find(params[:id])
        @punches = @employee.punches.order('created_at DESC')
    end

    def employee_shifts
        @employee = User.find(params[:id])
        @shifts = @employee.shifts.where('start > ?', Date.today.in_time_zone(current_user.time_zone).beginning_of_day).order('created_at DESC')
        # @shifts = @employee.shifts.all
    end

    def req_time
        @request = TimeOffRequest.new
        @curr_requests = current_user.time_off_requests.where('start > ?', Date.today.in_time_zone(current_user.time_zone).beginning_of_day).order('created_at DESC')
    end

    def create_req_time
        @employee = current_user.f_name + " " + current_user.l_name
        @request = TimeOffRequest.new(start: params[:time_off_request][:start].to_time, end: params[:time_off_request][:end].to_time, user_id: current_user.id, status:0, employee_name: @employee)
        if @request.save
            flash[:notice] = "Request successfully created!"
            redirect_to request_time_off_path
        else
            flash[:alert] = @request.errors.full_messages[0]
            render :req_time
        end
    end

    def view_requests
        @requests = TimeOffRequest.where(status:0)
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end

    def set_vars
        @company = Company.find(current_user.company_id)
        @user = current_user
    end

    def same_company?
        e =  User.find(params[:id])
        redirect_to root_path unless current_user.company_id == e.company_id
    end
end