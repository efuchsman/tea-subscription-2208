class Api::V1::CustomerTeaSubscriptionsController < ApplicationController

  def create
    customer = Customer.find_by(params[:id])
    tea = Tea.find_by(params[:id])
  end

end
