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

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: { success: "New customer successfully created"}
    else
      render json: customer.errors.messages, status: 400
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
