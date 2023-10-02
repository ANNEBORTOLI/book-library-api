require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { build(:book) }

  # Model validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:publication_year).with_message(/is not a number/) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:author) }
  it { should validate_uniqueness_of(:title) }
  it { should validate_numericality_of(:publication_year).is_less_than_or_equal_to(Date.today.year) }
  it { should belong_to(:genre) }
  it { should belong_to(:author) }
end
