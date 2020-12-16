class PunchController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    def clock_in
        current_user.update!(last_time: Time.current, status:0)
        flash[:notice] = "Successfully clocked in!"
        redirect_back(fallback_location: 'dashboard_controller#index')
    end

    def clock_out
        i = current_user.last_time
        o = Time.current
        d = (o.to_f - i.to_f) / 3600.to_f
        current_user.update!(last_time:o, status:1)
        @punch = current_user.punches.build(in:i,out:o,duration:d)
        @punch.save!
        flash[:notice] = "Successfully clocked out!"
        redirect_back(fallback_location: 'dashboard_controller#index')
    end
end