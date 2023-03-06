Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/customer", to: "customers#show"
      post "/add-subscription", to: "customer_subscriptions#create"
      patch "/cancel-subscription", to: "customer_subscriptions#cancel_subscription"
      post "/new-customer", to: "customers#create"
      delete "/delete-customer", to: "customers#delete"
    end
  end
end
