require 'rails_helper'

RSpec.describe CustomerTeaSubscription, type: :model do
  describe "Relationships" do
    it { should belong_to :customer }
    it { should belong_to :tea }
    it { should belong_to :subscription }
  end

  describe "Validations" do
    it { should validate_presence_of :status }
  end
end
