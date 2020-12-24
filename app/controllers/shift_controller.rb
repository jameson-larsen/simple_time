class ShiftController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :same_company?
    before_action :is_admin?
    
    def new
        @employee = User.find(params[:id])
        @shift = Shift.new
    end

    def create
        @employee = User.find(params[:id])
        d = (params[:shift][:end].to_time.to_f - params[:shift][:start].to_time.to_f) / 3600.to_f
        @shift = Shift.new(start: params[:shift][:start].to_time, end: params[:shift][:end].to_time, duration: d, user_id: @employee.id)
        if @shift.save
            flash[:notice] = "Shift successfully created!"
            redirect_to employee_shifts_path(@employee)
        else
            flash[:alert] = @shift.errors.full_messages[0]
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
        @shift = Shift.find(params[:shift_id])
    end

    def update
        @employee = User.find(params[:id])
        @shift = Shift.find(params[:shift_id])
        d = params[:shift][:end].to_time.to_f - params[:shift][:start].to_time.to_f
        @shift.update(start: params[:shift][:start].to_time, end: params[:shift][:end].to_time, duration: d/3600.0)
        if @shift.save
            flash[:notice] = "Successfully edited shift!"
            redirect_to employee_shifts_path(@employee)
        else
            flash[:alert] = @shift.errors.full_messages[0]
            render :edit
        end
    end

    def destroy
        @employee = User.find(params[:id])
        @shift = Shift.find(params[:shift_id])
        if @shift.destroy
            flash[:notice] = "Successfully deleted shift!"
        else
            flash[:alert] = "Shift could not be deleted!"
        end
        redirect_to employee_shifts_path(@employee)
    end

    private
    def same_company?
        e =  User.find(params[:id])
        redirect_to root_path unless current_user.company_id == e.company_id
    end

    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end

end