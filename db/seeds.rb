require 'faker'
require 'database_cleaner'

puts "Cleaning database..."
DatabaseCleaner.clean_with(:truncation)

puts 'Seeding data'
puts "Creating user..."

User.create!(email: 'test@email.com', password: '123456')

puts "Creating genres..."

5.times do |g|
  Genre.create!(name: "#{Faker::Book.genre}-#{g}")
end

puts "Creating authors..."

5.times do |a|
  Author.create!(name: "#{Faker::Book.author}-#{a}")
end

puts "Creating books..."

5.times do |b|
  Book.create!(
    title: "#{Faker::Book.title} #{b}",
    publication_year: (Date.today.year - 100) + rand(101),
    genre_id: rand(1..5),
    author_id: rand(1..5)
  )
end

puts 'Finished!'
