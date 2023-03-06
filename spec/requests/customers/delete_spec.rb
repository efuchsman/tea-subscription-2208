require "rails_helper"

RSpec.describe "/delete-customer" do
  describe "DELETE customer Endpoint" do
    let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
    }
    let!(:tea_1) { Tea.create!(title: "title", description: "desc", temperature: "temp", brew_time: "temp")
    }
    let!(:sub_1) { Subscription.create!(title: "title1", price: "$1", frequency: "freq1")
    }
    let!(:sub_2) { Subscription.create!(title: "title2", price: "$2", frequency: "freq2")
    }
    let!(:sub_t_1) { SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_1.id)
    }
    let!(:sub_t_2) { SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_2.id)
    }
    let!(:sub_t_2) { SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_2.id)
    }

    let!(:c_sub_1) { CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: sub_1.id)
    }

    let!(:c_sub_2) { CustomerSubscription.create!(status: 1, customer_id: customer_1.id, subscription_id: sub_2.id)
    }

    let!(:c_sub_3) { CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: sub_2.id)
    }

    describe "When the record exists and the proper api key is provided" do
      it "deletes the customer and their subs" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "id": customer_1.id,
          "api_key": ENV['DELETE_API_KEY']
          })

          delete '/api/v1/delete-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(json).to be_a Hash
          expect(json).to be_a Hash
          expect(json).to have_key :success
      end
    end

    describe "When the id is nil" do
      it "returns an error" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "id": 9000,
          "api_key": ENV['DELETE_API_KEY']
          })

          delete '/api/v1/delete-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to_not be_successful
          expect(response).to have_http_status(404)
          expect(json).to be_a Hash
          expect(json).to have_key :error
          expect(json[:error]).to eq("No customer found with that ID")
      end
    end

    describe "When no customer ID is provided" do
      it "returns an error" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "api_key": ENV['DELETE_API_KEY']
          })

          delete '/api/v1/delete-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
          expect(json).to be_a Hash
          expect(json).to have_key :error
          expect(json[:error]).to eq("Please provide a Customer ID")
      end
    end

    describe "When the API key is incorrect or missing" do
      it "returns an error" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
          "id": 9000,
          "api_key": "OIJoij0a9f-09i0"
          })

          delete '/api/v1/delete-customer', headers: headers, params: JSON.generate(body)

          json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
          expect(json).to be_a Hash
          expect(json).to have_key :error
          expect(json[:error]).to eq("API credential error")
      end
    end
  end
end
