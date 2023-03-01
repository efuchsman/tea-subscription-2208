class Api::V1::CustomersController < ApplicationController

  def show
    id = params[:id]

    if id.present?
      customer = Customer.find_by(id: id)
      if customer.nil?
        render json: { error: "No customer found with that ID" }, status: 404
      else
        render json: CustomerSerializer.new(customer)
      end
    else
     render json: { error: "Please provide an id parameter in the URL path" }, status: 400
    end
  end
end
