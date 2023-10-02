FactoryBot.define do
  sequence :unique_author_name do |n|
    "#{Faker::Book.author}-#{n}"
  end

  factory :author do
    name { generate(:unique_author_name) }
  end
end
