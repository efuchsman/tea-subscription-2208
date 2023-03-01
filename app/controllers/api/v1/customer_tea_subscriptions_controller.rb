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
        render json: { error: "One or more of the IDs provided do not exist"}
      else
        customer_tea_subscription = CustomerTeaSubscription.new(new_customer_tea_sub_params)
        if customer_tea_subscription.save
          render json: { success: "Customer tea subscription has been successfully activated" }
        end
      end
    else
      render json: { error: "Missing Required Parameters" }, status: 404
    end
  end

  private

  def new_customer_tea_sub_params
    params.permit(:customer_id, :tea_id, :subscription_id)
  end
end
