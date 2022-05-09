class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.belongs_to :order, foreign_key: true
      t.decimal :sale, precision: 8, scale: 2, null: false
      t.string :code, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
