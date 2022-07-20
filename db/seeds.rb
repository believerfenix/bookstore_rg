# frozen_string_literal: true

require 'faker'

10.times { Author.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)}
10.times { Category.create(name: Faker::Book.genre)}

50.times do
  book = Book.create(
    title: Faker::Book.title,
    price: Faker::Number.decimal(l_digits: 2),
    quantity: Faker::Number.between(from: 1, to: 100),
    description: Faker::Lorem.paragraph_by_chars,
    publication_year: Faker::Number.between(from: 1980, to: 2020),
    height: Faker::Number.decimal(l_digits: 2),
    width: Faker::Number.decimal(l_digits: 2),
    depth: Faker::Number.decimal(l_digits: 2),
    materials: Faker::Science.element,
    category: Category.all.sample
  )
  book.authors << Author.all.sample(rand(1..3))
  book.title_image.attach(io: File.open('app/assets/images/default_book.png'), filename: 'default_book.png', content_type: 'image/png')
  3.times do
    book.images.attach(io: File.open('app/assets/images/default_book.png'), filename: 'default_book.png', content_type: 'image/png')
  end
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
