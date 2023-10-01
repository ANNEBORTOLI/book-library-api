require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { build(:genre) }

  # Model validation tests
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
