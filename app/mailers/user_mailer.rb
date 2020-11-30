class UserMailer < ApplicationMailer
    default from: 'simpletimeleads@gmail.com'

    def lead_mail(email, phone, name, company, employees)
        @email = email
        @phone = phone
        @name = name
        @company = company
        @employees = employees
        mail(to: "simpletimeleads@gmail.com", subject: "New Lead")
    end
end
