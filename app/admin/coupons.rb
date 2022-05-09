# frozen_string_literal: true

ActiveAdmin.register Coupon do
  permit_params :sale, :code
end
