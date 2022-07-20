# frozen_string_literal: true

class CreateOrderDeliveryTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_delivery_types do |t|
      t.belongs_to :delivery_type, foreign_key: true
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
