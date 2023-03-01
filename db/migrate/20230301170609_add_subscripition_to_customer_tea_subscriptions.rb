class AddSubscripitionToCustomerTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :customer_tea_subscriptions, :subscription, foreign_key: true
  end
end
