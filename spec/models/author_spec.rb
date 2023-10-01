require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { build(:author) }

  # Model validation tests
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
