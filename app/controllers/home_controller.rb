class HomeController < ApplicationController
    def index
    end

    def send_email
        UserMailer.lead_mail(params[:lead]['email'], params[:lead]['phone'], params[:lead]['name'], params[:lead]['company'], params[:lead]['employees']).deliver_now
    end
end
