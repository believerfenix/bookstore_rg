# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    address_form = AddressForm.new(address_params)
    if address_form.save
      flash[:success] = t('address.form.success', kind: address_params[:kind])
    else
      flash[:danger] = address_form.errors.full_messages.to_sentence
    end
    redirect_to edit_user_registration_path
  end

  def address_params
    params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone,
                                         :kind).merge(user: current_user)
  end
end
