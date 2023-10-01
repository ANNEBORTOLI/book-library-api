FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    publication_year { Faker::Number.between(from: 0, to: Date.today.year) }
    genre { create(:genre) }
    author { create(:author) }
  end
end
