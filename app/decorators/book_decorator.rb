# frozen_string_literal: true

class BookDecorator < ApplicationDecorator
  TRUNCATED_LENGTH = { description: 150,
                       all_authors_fullname: 15,
                       title: 20 }.freeze

  delegate_all

  def all_authors_fullname
    authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def truncated_all_authors_fullname
    all_authors_fullname.truncate(TRUNCATED_LENGTH[:all_authors_fullname], separator: ' ')
  end

  def truncated_title
    title.truncate(TRUNCATED_LENGTH[:title], separator: ' ')
  end

  def short_description
    description.truncate(TRUNCATED_LENGTH[:description], separator: ' ')
  end

  def resize_title_image(size)
    title_image.variant(resize_to_limit: [size, size])
  end

  def resized_images(size)
    images.each { |image| image.variant(resize_to_limit: [size, size]) }
  end
end
