# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.text :description
      t.integer :publication_year
      t.decimal :height, precision: 10, scale: 2
      t.decimal :width, precision: 10, scale: 2
      t.decimal :depth, precision: 10, scale: 2
      t.string :materials
      t.references :category, foreing_key: true

      t.timestamps
    end
  end
end
