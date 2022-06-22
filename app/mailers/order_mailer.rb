# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_completed(order, user)
    @order = order.decorate
    mail(to: user.email, subject: I18n.t('order_mailer.subject', order_number: order.id))
  end
end
