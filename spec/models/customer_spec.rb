require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationship" do
    it { should have_many :customer_tea_subscriptions}
    it { should have_many(:teas).through(:customer_tea_subscriptions) }
  end

  describe "Validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :address }
  end

  describe "Instance Methods" do
    let!(:customer_1) { Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "el@mail.com", address: "Eli's address")
    }

    let!(:customer_2) { Customer.create!(first_name: "Eli2", last_name: "Fuchsman2", email: "el2@mail.com", address: "Eli2's address")
    }

    let!(:tea_1) { Tea.create!(title: "title", description: "desc", temperature: "temp", brew_time: "temp")
    }
    let!(:sub_1) { CustomerTeaSubscription.create!(title: "title1", price: "$1", frequency: "freq1", customer_id: customer_1.id, tea_id: tea_1.id)
    }

    let!(:sub_2) { CustomerTeaSubscription.create!(title: "title2", price: "$2", status: 1, frequency: "freq2", customer_id: customer_1.id, tea_id: tea_1.id)
    }

    let!(:sub_3) { CustomerTeaSubscription.create!(title: "title3", price: "$3", frequency: "freq3", customer_id: customer_1.id, tea_id: tea_1.id)
    }

    describe "#active_subscriptions" do
      it "is an array of that customers active subs" do

        expect(customer_1.active_subscriptions.count).to eq(2)
        expect(customer_1.active_subscriptions).to eq([sub_1, sub_3])
        expect(customer_2.active_subscriptions.count).to eq(0)
      end
    end

    describe "#canceled_subscriptions" do
      it "is an array of that customers canceled subs" do
        expect(customer_1.canceled_subscriptions.count).to eq(1)
        expect(customer_1.canceled_subscriptions).to eq([sub_2])
      end
    end
  end
end
