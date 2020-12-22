class PunchController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?, only: [:edit, :update, :destroy, :new, :create]
    before_action :same_company?, only: [:edit, :update, :destroy, :new, :create]

    def clock_in
        current_user.update!(last_time: Time.current, status:0)
        if current_user.save
            flash[:notice] = "Successfully clocked in!"
        else 
            flash[:alert] = "Clock in failed, please try again!"
        end
        redirect_to :controller => 'dashboard', :action => 'index'
    end

    def clock_out
        i = current_user.last_time
        o = Time.current
        d = (o.to_f - i.to_f) / 3600.to_f
        current_user.update!(last_time:o, status:1)
        @punch = current_user.punches.build(in:i,out:o,duration:d)
        if @punch.save!
            flash[:notice] = "Successfully clocked out!"
        else
            flash[:alert] = "Clock out failed, please try again!"
        end
        redirect_to :controller => 'dashboard', :action => 'index'
    end

    def edit
        @user = User.find(params[:id])
        @punch = Punch.find(params[:punch_id])
    end

    def update
        @employee = User.find(params[:id])
        @punch = Punch.find(params[:punch_id])
        d = params[:punch][:out].to_time.to_f - params[:punch][:in].to_time.to_f
        @punch.update(in: params[:punch][:in].to_time, out: params[:punch][:out].to_time, duration: d/3600.0)
        if @punch.in < @punch.out
            if @punch.save
                flash[:notice] = "Successfully edited punch!"
                redirect_to employee_punches_path(@employee)
            else
                flash[:alert] = "Punch edit failed!"
                render :edit
            end
        else
            flash[:alert] = "Clock out must be after clock in!"
            render :edit
        end
    end

    def destroy
        @employee = User.find(params[:id])
        @punch = Punch.find(params[:punch_id])
        if @punch.destroy
            flash[:notice] = "Successfully deleted punch!"
        else
            flash[:alert] = "Punch could not be deleted!"
        end
        redirect_to employee_punches_path(@employee)
    end

    def new
        @employee = User.find(params[:id])
        @punch = Punch.new
    end
    
    def create
        @employee = User.find(params[:id])
        d = (params[:punch][:out].to_time.to_f - params[:punch][:in].to_time.to_f) / 3600.to_f
        @punch = Punch.new(in: params[:punch][:in].to_time, out: params[:punch][:out].to_time, duration: d, user_id: @employee.id)
        if @punch.in < @punch.out
            if @punch.save!
                flash[:notice] = "Punch successfully created!"
                redirect_to employee_punches_path(@employee)
            else
                flash[:alert] = "Punch could not be created!"
                render :new
            end
        else
            flash[:alert] = "Clock out must be after clock in!"
            render :new
        end
    end



    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end

    def same_company?
        e =  User.find(params[:id])
        redirect_to root_path unless current_user.company_id == e.company_id
    end

end