# frozen_string_literal: true

ActiveAdmin.register Review do
  actions :index, :show
  permit_params :book_id, :title, :body, :date, :user_id, :status

  scope :unprocessed, default: true
  scope :processed

  index do
    selectable_column
    column :book
    column :title
    column :book_rate
    column :date
    column :user
    column :status
    actions
  end

  show do
    attributes_table do
      row :book
      row :title
      row :book_rate
      row :body
      row :date
      row :user
      row :status
    end
  end

  action_item :approve, only: :show do
    link_to I18n.t('activeadmin.reviews.approve'), approve_admin_review_path(resource), method: :put
  end

  action_item :reject, only: :show do
    link_to I18n.t('activeadmin.reviews.reject'), reject_admin_review_path(resource), method: :put
  end

  member_action :approve, method: :put do
    resource.approved!
    redirect_to(resource_path, notice: I18n.t('activeadmin.reviews.approved'))
  end

  member_action :reject, method: :put do
    resource.rejected!
    redirect_to(resource_path, notice: I18n.t('activeadmin.reviews.rejected'))
  end
end
