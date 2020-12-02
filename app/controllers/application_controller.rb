class ApplicationController < ActionController::Base
    around_action :switch_time_zone, :if => :current_user

    def switch_time_zone(&block)
        Time.use_zone(current_user.time_zone, &block)
    end
    def after_sign_in_path_for(resource)
        dashboard_path
    end
end
