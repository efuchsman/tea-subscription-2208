require "rails_helper"

RSpec.describe "/customer" do
  describe "GET customer show Endpoint" do
    describe "When the record exists" do
      let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
      }

      it "returns a customer" do
        get "/api/v1/customer?id=#{customer_1.id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end
end
