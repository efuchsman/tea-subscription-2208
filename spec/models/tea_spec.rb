require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "Relationships" do
    it { should have_many :subscription_teas }
    it { should have_many(:subscriptions).through(:subscription_teas) }
    it { should have_many(:customer_subscriptions).through(:subscriptions) }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end

  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temperature }
    it { should validate_presence_of :brew_time }
  end
end
