require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe "Relationships" do
    it { should belong_to :customer }
    it { should belong_to :subscription }
  end

  describe "Validations" do
    it { should validate_presence_of :status }
  end
end
