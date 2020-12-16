class DashboardController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    def index
        @user = current_user
        @company = Company.find(current_user.company_id)
        @punches = current_user.punches
    end

    def schedule
        @user = current_user
        @company = Company.find(current_user.company_id)
        @shifts = current_user.shifts
    end
end