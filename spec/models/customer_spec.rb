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
end
