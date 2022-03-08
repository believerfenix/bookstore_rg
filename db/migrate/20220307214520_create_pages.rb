# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages, &:timestamps
  end
end
