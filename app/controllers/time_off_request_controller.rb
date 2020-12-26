class TimeOffRequestController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?
    before_action :same_company?

    def accept
        @request = TimeOffRequest.find(params[:request_id])
        @request.update(status:2)
        if @request.save
            flash[:notice] = "Request accepted!"
        else
            flash[:alert] = "Something went wrong, please try again."
        end
        redirect_to view_requests_path
    end

    def deny
        @request = TimeOffRequest.find(params[:request_id])
        @request.update(status:1)
        if @request.save
            flash[:notice] = "Request denied!"
        else
            flash[:alert] = "Something went wrong, please try again."
        end
        redirect_to view_requests_path
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end

    def same_company?
        e = User.find(TimeOffRequest.find(params[:request_id]).user_id)
        redirect_to root_path unless current_user.company_id == e.company_id
    end

end