require "rails_helper"

RSpec.describe "/add-subscription" do
  describe "POST new subscription endpoint" do
    let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
    }
    let!(:customer_2) { Customer.create!(first_name: "Eli2", last_name: "Fuchsman2", email: "el2@mail.com", address: "Eli2's address")
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

    describe "When all parameters exist in the database" do
      it 'returns a success response and message' do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
            "customer_id": customer_1.id,
            "subscription_id": sub_2.id
          })

        expect(customer_1.active_subscriptions.count).to eq(0)

        post '/api/v1/add-subscription', headers: headers, params: JSON.generate(body)

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(customer_1.active_subscriptions.count).to eq(1)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :success
        expect(json[:success]).to eq("Customer subscription has been successfully activated")
      end
    end

    describe "When a parameter is missing" do
        it "returns a bad request error" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
            "customer_id": customer_1.id,
          })

        post '/api/v1/add-subscription', headers: headers, params: JSON.generate(body)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(400)
        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to eq("Missing one or more required parameters")
      end
    end

    describe "When parameters do not exist" do
      it "returns a not found response" do
        headers = { "Content-Type": "application/json", Accept: "application/json" }

        body = ({
            "customer_id": customer_1.id,
            "subscription_id": 35
          })

        post '/api/v1/add-subscription', headers: headers, params: JSON.generate(body)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)
        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to eq("One or more of the IDs provided does not exist")
      end
    end
  end
end
