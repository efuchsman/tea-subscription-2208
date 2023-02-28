class CustomerTeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :status
  validates_presence_of :frequency

  enum status: { active: 0, cancelled: 1}
end
