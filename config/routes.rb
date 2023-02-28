Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/customer", to: "customers#show"
    end
  end
end
