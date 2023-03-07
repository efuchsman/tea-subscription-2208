class CustomerMailer < ApplicationMailer
  def welcome_customer
    @customer = params[:customer]
    @greeting = "Hello #{@customer.first_name}"

    mail(to: @customer.email, subject: "Welcome to Tea Subscription")
  end
end
