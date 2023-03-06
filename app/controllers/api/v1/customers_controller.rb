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

  def delete
    id = params[:id]
    api_key = params[:api_key]

    if id.present? && api_key == ENV['DELETE_API_KEY']
      customer = Customer.find_by(id: id)
      if customer.nil?
        render json: { error: "No customer found with that ID" }, status: 404
      else
        customer.customer_subscriptions.delete_all
        customer.delete
        render json: { success: "Customer successfully deleted"}
      end
    elsif !id.present? && api_key == ENV['DELETE_API_KEY']
      render json: { error: "Please provide a Customer ID" }, status: 400
    elsif (id.present? || !id.present?) && (api_key != ENV['DELETE_API_KEY'] || !api_key.present?)
      render json: { error: "API credential error" }, status: 400
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
