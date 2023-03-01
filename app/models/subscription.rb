class Subscription < ApplicationRecord
  has_many :customer_tea_subscriptions
  has_many :customers, through: :customer_tea_subscriptions
  has_many :teas, through: :customer_tea_subscriptions

  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :frequency
end
