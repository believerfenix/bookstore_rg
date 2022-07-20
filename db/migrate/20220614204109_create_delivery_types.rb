# frozen_string_literal: true

class CreateDeliveryTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_types do |t|
      t.string :name
      t.integer :min_days
      t.integer :max_days
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
