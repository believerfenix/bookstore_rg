# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  enum kind: { billing: 0, shipping: 1 }
end
