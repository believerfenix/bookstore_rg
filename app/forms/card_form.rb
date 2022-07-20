# frozen_string_literal: true

class CardForm
  include ActiveModel::Model

  attr_accessor :number, :name, :expiry_date, :cvv

  FORMAT = {
    text: /\A[a-zA-Z\s]+\z/,
    numeric: /\A\d+\z/,
    date: %r/\A(0[1-9]|10|11|12)\/[0-9]{2}\z/
  }.freeze

  LENGTH = {
    max_name: 50,
    min_cvv: 3,
    max_cvv: 4
  }.freeze

  validates :number, :name, :expiry_date, :cvv, presence: true
  validates :number, format: { with: FORMAT[:numeric] }
  validates :name, format: { with: FORMAT[:text] }, length: { maximum: LENGTH[:max_name] }
  validates :expiry_date, format: { with: FORMAT[:date] }
  validates :cvv, format: { with: FORMAT[:numeric] }, length: { minimum: LENGTH[:min_cvv], maximum: LENGTH[:max_cvv] }

  def save(object)
    return false if invalid?

    object.create_card(params)
  end

  def params
    {
      name: name,
      expiry_date: expiry_date,
      cvv: cvv,
      number: number
    }
  end
end
