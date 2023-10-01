FactoryBot.define do
  sequence :unique_title do |n|
    "Book Title #{n}"
  end

  sequence :unique_publication_year do
    (Date.today.year - 100) + rand(101)
  end

  factory :book do
    title { generate(:unique_title) }
    publication_year { generate(:unique_publication_year) }
    genre { create(:genre) }
    author { create(:author) }
  end
end
