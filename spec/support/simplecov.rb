# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
  minimum_coverage 90
end
