FactoryBot.define do
  factory :book do
    title { "MyString" }
    publication_year { 1 }
    genre { nil }
    author { nil }
  end
end
