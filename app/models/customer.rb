class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :subscription_teas, through: :subscriptions
  has_many :teas, through: :subscription_teas

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :address
  validates_uniqueness_of :email

  def active_subscriptions
    self.customer_subscriptions
    .where('customer_subscriptions.status = 0')
  end

  def canceled_subscriptions
    self.customer_subscriptions
    .where('customer_subscriptions.status = 1')
  end
end
