class CompanyController < ApplicationController
    before_action :admin_created?, only: [:first_user, :create_first_user]

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(name: params[:company][:name], num_employees: params[:company][:num_employees].to_i, time_zone: params[:company][:time_zone], num_employees_registered:0)
        if @company.save
            flash[:notice] = "Company registration successful!"
            redirect_to add_initial_user_path(@company)
        else
            flash[:alert] = "Company registration unsuccessful, please try again!"
            render :new
        end
    end

    def first_user
        @user = User.new
        @company = Company.find(params[:company_id])
    end

    def create_first_user
        @company = Company.find(params[:company_id])
        @user = User.new(f_name: params[:user][:f_name], l_name: params[:user][:l_name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], status:1, user_role:1, password_changed:1, company_id: @company.id, time_zone: @company.time_zone)
        if @user.save
            @company.update(num_employees_registered: @company.num_employees_registered + 1)
            if @company.save
                flash[:notice] = "Admin user successfully created!"
                redirect_to new_user_session_path
            else
                flash[:alert] = "Admin user could not be created, please try again!"
                render :first_user
            end
        else
            flash[:alert] = @user.errors.full_messages[0]
            render :first_user
        end
    end

    private
    def admin_created?
        redirect_to root_path unless Company.find(params[:company_id]).num_employees_registered == 0
    end
end