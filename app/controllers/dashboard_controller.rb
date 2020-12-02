class DashboardController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    def index
        @user = current_user
        @company = Company.find(current_user.company_id)
    end
end