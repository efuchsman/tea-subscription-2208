Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/customer", to: "customers#show"
      post "/add-tea-subscription", to: "customer_tea_subscriptions#create"
      patch "/cancel-subscription", to: "customer_tea_subscriptions#cancel_subscription"
    end
  end
end
