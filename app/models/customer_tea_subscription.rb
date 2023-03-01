class CustomerTeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  belongs_to :subscription
  validates_presence_of :status
  enum status: { active: 0, canceled: 1 }
end
