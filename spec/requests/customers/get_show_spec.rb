require "rails_helper"

RSpec.describe "/customer" do
  describe "GET customer show Endpoint" do
    describe "When the record exists" do
      let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
      }

      before :each do
        get "/api/v1/customer?id=#{customer_1.id}"

        @json = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a customer successfully" do

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        expect(@json).to be_a Hash
        expect(@json).to have_key :data

        expect(@json[:data]).to be_a Hash

        expect(@json[:data]).to have_key :id
        expect(@json[:data]).to have_key :type
        expect(@json[:data]).to have_key :attributes

        expect(@json[:data][:id]).to be_a String
        expect(@json[:data][:type]).to be_a String
        expect(@json[:data][:attributes]).to be_a Hash
      end

      it "returns additional attributes" do

        expect(@json[:data][:attributes]).to have_key :first_name
        expect(@json[:data][:attributes]).to have_key :last_name
        expect(@json[:data][:attributes]).to have_key :email
        expect(@json[:data][:attributes]).to have_key :address
        expect(@json[:data][:attributes]).to have_key :active_subscriptions
        expect(@json[:data][:attributes]).to have_key :canceled_subscriptions
      end
    end

    describe "When no ID matches the one provided" do
      it "returns an error" do
        get "/api/v1/customer?id=10000000000"

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to be_a String
      end
    end

    describe "When there is no ID provided" do
      it "returns an error" do
        get "/api/v1/customer"

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to be_a String
      end
    end
  end
end
