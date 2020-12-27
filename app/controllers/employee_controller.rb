class EmployeeController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?

    def admin_new_user
        @user = User.new
    end

    def admin_create_user
        tz = Company.find(current_user.company_id).time_zone
        @user = User.new(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], f_name: params[:user][:f_name], l_name: params[:user][:l_name], user_role:0, company_id: current_user.company_id, time_zone: tz)
        if @user.save
            flash[:notice] = "Employee successfully added!"
            redirect_to employees_path
        else
            flash[:alert] = @user.errors.full_messages[0]
            render :admin_new_user
        end
    end

    def admin_delete_user
        @user = User.find(params[:id])
        if @user.destroy
            flash[:notice] = "Employee successfully deleted!"
            redirect_to employees_path
        else
            flash[:alert] = "Employee could not be deleted!"
            redirect_to employees_path
        end
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end
end