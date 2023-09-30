class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :author

  validates :publication_year, comparison: { less_than_or_equal_to: Date.today }
  validates :title, presence: true, uniqueness: true
  validates :genre, presence: true
  validates :author, presence: true
end
