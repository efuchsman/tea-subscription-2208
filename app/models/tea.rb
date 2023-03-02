class Tea < ApplicationRecord
  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
  has_many :customer_subscriptions, through: :subscriptions
  has_many :customers, through: :customer_subscriptions

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :temperature
  validates_presence_of :brew_time
end
