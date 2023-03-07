require "rails_helper"

RSpec.describe CustomerMailer, type: :mailer do
  describe "welcome_customer" do

    let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
    }
    let!(:mail) { CustomerMailer.with(customer: Customer.last).welcome_customer }

    it "renders the headers" do

      expect(mail.subject).to eq("Welcome to Tea Subscription")
      expect(mail.to).to eq(["el@mail.com"])
      expect(mail.from).to eq(["welcome@teaservice.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello #{customer_1.first_name}, we are so delighted that you created an account with us!")
    end
  end

end
