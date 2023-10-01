# FactoryBot.define do
#   factory :author do
#     name { Faker::Book.author }
#   end
# end

FactoryBot.define do
  sequence :unique_author_name do |n|
    "#{Faker::Book.author}-#{n}"
  end

  factory :author do
    name { generate(:unique_author_name) }
  end
end
