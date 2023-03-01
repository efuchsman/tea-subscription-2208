class CreateCustomerTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_tea_subscriptions do |t|
      t.integer :status, default: 0
      t.references :customer, foreign_key: true
      t.references :tea, foreign_key: true

      t.timestamps
    end
  end
end
