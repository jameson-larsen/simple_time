class ExportController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :is_admin?
    
    def new
    end

    def create
       @start = params[:export][:start_date]
       @end = params[:export][:end_date]
       redirect_to display_report_path(@start, @end)
    end

    def export
        @employees = Company.find(current_user.company_id).users.all
        @start = params[:start_date]
        @end = params[:end_date]
        respond_to do |format|
          format.xlsx {
            response.headers[
              'Content-Disposition'
            ] = "attachment; filename=report.xlsx"
           }
       end
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.user_role == "admin"
    end
end