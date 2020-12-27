class EmployeeController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!, except: [:new_user, :create_user]
    before_action :is_admin?, except: [:new_user, :create_user]
    before_action :valid_link?, only: [:new_user, :create_user]

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

    def new_user
        @user = User.new
    end

    def create_user
        company = Company.where(registration_token: params[:registration_token]).first
        tz = company.time_zone
        @user = User.new(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], f_name: params[:user][:f_name], l_name: params[:user][:l_name], user_role:0, company_id: company.id, time_zone: tz)
        if @user.save
            flash[:notice] = "Profile successfully created!"
            redirect_to new_user_session_path
        else
            flash[:alert] = "Profile could not be created!"
            render :create_user
        end
    end

    def upgrade_admin
        @user = User.find(params[:id])
        if @user.user_role == "employee"
            @user.update(user_role:1)
        else
            @user.update(user_role:0)
        end
        if @user.save
            flash[:notice] = "Success!"
        else
            flash[:alert] = "User couldn't be updated!"
        end
        redirect_to employee_path(@user)
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end

    def valid_link?
        c = Company.where(registration_token: params[:registration_token]).first
        if c.nil?
            redirect_to root_path
        end
    end

end