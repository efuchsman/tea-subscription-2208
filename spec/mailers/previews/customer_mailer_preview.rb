# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/welcome_customer
  def welcome_customer
    CustomerMailer.with(customer: Customer.last).welcome_customer
  end
end
