class Tea < ApplicationRecord
  has_many :customer_tea_subscriptions
  has_many :customers, through: :customer_tea_subscriptions

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :temperature
  validates_presence_of :brew_time
end
