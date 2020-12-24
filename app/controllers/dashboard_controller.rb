class DashboardController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?, only: [:employees, :show_employee, :employee_calendar, :employee_punches, :employee_shifts]
    before_action :set_vars
    before_action :same_company?, only: [:show_employee, :employee_calendar, :employee_punches, :employee_shifts]

    def index
        @punches = current_user.punches
    end

    def schedule
        @shifts = current_user.shifts
        @punches = current_user.punches
    end

    def employees
        @admin = current_user
        @employees = @company.users.search(params[:search]).order('l_name ASC')
    end

    def show_employee
        @employee = User.find(params[:id])
        @hours_between = @employee.hours_between(params[:date1],params[:date2])
    end

    def employee_calendar
        @employee = User.find(params[:id])
        @shifts = @employee.shifts
        @punches = @employee.punches
    end

    def employee_punches
        @employee = User.find(params[:id])
        @punches = @employee.punches.order('created_at DESC')
    end

    def employee_shifts
        @employee = User.find(params[:id])
        @shifts = @employee.shifts.order('created_at DESC')
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