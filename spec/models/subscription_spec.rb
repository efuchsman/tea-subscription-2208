require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Relationships" do
    it { should have_many :customer_tea_subscriptions }
    it { should have_many(:teas).through(:customer_tea_subscriptions) }
    it { should have_many(:customers).through(:customer_tea_subscriptions) }
  end

  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :frequency }
  end
end
