# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :number
      t.string :name
      t.string :expiry_date
      t.integer :cvv
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
