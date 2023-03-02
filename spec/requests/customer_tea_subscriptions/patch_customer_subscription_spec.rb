require "rails_helper"

RSpec.describe "/cancel-subscription" do
  describe "PATCH new subscription endpoint" do
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
    let!(:c_sub_1) { CustomerTeaSubscription.create!(customer_id: customer_1.id, tea_id: tea_1.id, subscription_id: sub_1.id)
    }
    let!(:c_sub_2) { CustomerTeaSubscription.create!(status: 1, customer_id: customer_2.id, tea_id: tea_1.id, subscription_id: sub_1.id)
    }

    describe "When the customer has an active subscription" do
      it "updates the status to canceled" do
        expect(customer_1.active_subscriptions.count).to eq(1)
        expect(customer_1.canceled_subscriptions.count).to eq(0)

        patch "/api/v1/cancel-subscription?id=#{c_sub_1.id}"
        json = JSON.parse(response.body, symbolize_names: true)

        expect(customer_1.active_subscriptions.count).to eq(0)
        expect(customer_1.canceled_subscriptions.count).to eq(1)
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(json).to be_a Hash
        expect(json).to have_key :success
        expect(json[:success]).to eq("Customer subscription has been successfully canceled")
      end
    end

    describe "when the active subscription does not exist" do
      it "return a not found response" do

        patch "/api/v1/cancel-subscription?id=4000"
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to eq("ID provided does not exist")
      end
    end

    describe "When the subscription is already is already canceled" do
      it "returns a conflict error" do
        patch "/api/v1/cancel-subscription?id=#{c_sub_2.id}"
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(409)
        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to eq("Customer subscription has already been canceled")
      end
    end

    describe "When there is no id provided" do
      it 'returns a bad request error' do
        patch "/api/v1/cancel-subscription"
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(400)

        expect(json).to be_a Hash
        expect(json).to have_key :error
        expect(json[:error]).to eq("Please provide an id parameter in the URL path")
      end
    end
  end
end
