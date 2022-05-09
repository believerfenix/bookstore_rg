class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.belongs_to :book, foreign_key: true
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
