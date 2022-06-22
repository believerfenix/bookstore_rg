# frozen_string_literal: true

class CheckoutsController < ApplicationController
  ORDER_STATES = {
    address: Checkout::OrderAddressUpdateService,
    delivery: Checkout::OrderDeliveryUpdateService,
    payment: Checkout::OrderCardUpdateService
  }.freeze

  def show
    change_state(params[:state]) if params[:state]
    @order = current_cart.decorate
  end

  def update
    service_class = ORDER_STATES[current_cart.state.to_sym]
    service = service_class.call(order: current_cart, order_params: order_params)

    flash[:danger] = service.errors_message unless service.success?
    redirect_to checkout_path
  end

  private

  def order_params
    params.require(:order).permit(:only_billing, :delivery_id,
                                  billing_address: %i[first_name last_name country city address zip phone kind],
                                  shipping_address: %i[first_name last_name country city address zip phone kind],
                                  card: %i[number name expiry_date cvv])
  end

  def change_state(state)
    send_complete_mail if state == Order.states.key(4)

    current_cart.update(state: state)
  end

  def send_complete_mail
    OrderMailer.order_completed(current_cart, current_user).deliver
  end
end
