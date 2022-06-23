# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :state

      t.date :completed_at, null: true

      t.timestamps
    end
  end
end
