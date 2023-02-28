class Customer < ApplicationRecord
  has_many :customer_tea_subscriptions
  has_many :teas, through: :customer_tea_subscriptions

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :address
  validates_uniqueness_of :email

  def active_subscriptions
    self.customer_tea_subscriptions
    .where('customer_tea_subscriptions.status = 0')
  end

  def cancelled_subscriptions
    self.customer_tea_subscriptions
    .where('customer_tea_subscriptions.status = 1')
  end
end
