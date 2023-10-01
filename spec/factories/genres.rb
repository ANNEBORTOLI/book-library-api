FactoryBot.define do
  sequence :unique_genre_name do |n|
    "#{Faker::Book.genre}-#{n}"
  end

  factory :genre do
    name { generate(:unique_genre_name) }
  end
end
