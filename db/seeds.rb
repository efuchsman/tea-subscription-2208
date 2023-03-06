# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  customer1 = Customer.create!(first_name: "Eli", last_name: "Fuchsman", email: "eli@mail.com", address: "Eli's address")

  tea_1 = Tea.create!(title: "title", description: "desc", temperature: "temp", brew_time: "temp")

  sub_1 = Subscription.create!(title: "title1", price: "$1", frequency: "freq1")

  sub_2 = Subscription.create!(title: "title2", price: "$2", frequency: "freq2")

  sub_t_1 = SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_1.id)

  sub_t_2 = SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_2.id)

  sub_t_2 = SubscriptionTea.create!(tea_id: tea_1.id, subscription_id: sub_2.id)


