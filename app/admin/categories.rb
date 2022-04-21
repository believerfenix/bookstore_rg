# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
end
