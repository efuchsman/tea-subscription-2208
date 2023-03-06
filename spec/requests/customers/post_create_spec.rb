require "rails_helper"

RSpec.describe "/new-customer" do
  describe "POST create customer endpoint" do
    describe "when all params are me" do
      it "creates a customer" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "first_name": "Eli",
          "last_name": "Fuchsman",
          "email": "eli2@mail.com",
          "address": "eli's address"
          })

          post '/api/v1/new-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(json).to be_a Hash
      end
    end

    describe "When parameters are missing" do
      it 'returns an error' do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "first_name": "Eli",
          "last_name": "Fuchsman",
          "email": "eli2@mail.com"
          })

          post '/api/v1/new-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
          expect(json).to be_a Hash
          expect(json).to have_key :address
      end
    end

    describe "When the email is already in use" do
      let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
      }
      it "returns an error" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "first_name": "Eli",
          "last_name": "Fuchsman",
          "email": "el@mail.com",
          "address": "eli's address"
          })

          post '/api/v1/new-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
          expect(json).to be_a Hash
          expect(json).to have_key :email
      end
    end
  end
end
