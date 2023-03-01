class Api::V1::CustomerTeaSubscriptionsController < ApplicationController

  def create
    customer_id = params[:customer_id]
    tea_id = params[:tea_id]
    subscription_id = params[:subscription_id]
    if customer_id.present? && tea_id.present? && subscription_id.present?
      customer = Customer.find_by(id: customer_id)
      tea = Tea.find_by(id: tea_id)
      subscription = Subscription.find_by(id: subscription_id)
      if customer.nil? || tea.nil? || subscription.nil?
        render json: { error: "One or more of the IDs provided does not exist"}, status: 404
      else
        customer_tea_subscription = CustomerTeaSubscription.new(new_customer_tea_sub_params)
        if customer_tea_subscription.save
          render json: { success: "Customer tea subscription has been successfully activated" }
        end
      end
    else
      render json: { error: "Missing one or more required parameters" }, status: 400
    end
  end

  def cancel_subscription
    sub_id = params[:id]
    if sub_id.present?
      customer_tea_subscription = CustomerTeaSubscription.find_by(id: params[:id])
      if !customer_tea_subscription.nil? && customer_tea_subscription.status == "active"
          customer_tea_subscription.update(status: "canceled")
          render json: { success: "Customer subscription has been successfully canceled" }
      elsif !customer_tea_subscription.nil? && customer_tea_subscription.status != "active"
        render json: { error: "Customer subscription has already been canceled" }, status: 409
      else
        render json: { error: "ID provided does not exist"}, status: 404
      end
    else
      render json: { error: "Please provide an id parameter in the URL path" }, status: 400
    end
  end

  private

  def new_customer_tea_sub_params
    params.permit(:customer_id, :tea_id, :subscription_id)
  end
end
