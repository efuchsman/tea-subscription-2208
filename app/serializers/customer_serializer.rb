class CustomerSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email, :address, :active_subscriptions, :cancelled_subscriptions

end
