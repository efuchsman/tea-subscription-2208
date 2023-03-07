require "rails_helper"

RSpec.describe CustomerMailer, type: :mailer do
  describe "welcome_customer" do
    let(:mail) { CustomerMailer.welcome_customer }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome customer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["welcome@teaservice.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
