class Book < ApplicationRecord
  # Associations
  belongs_to :author, foreign_key: :author_isan, primary_key: :isan
  belongs_to :publisher, foreign_key: :publisher_ispn, primary_key: :ispn
  belongs_to :category, foreign_key: :category_code, primary_key: :code

  # Validations

  # International Standard Book Number (ISBN) is a unique identifier for books.
  validates :isbn, presence: true, uniqueness: true
  validates :title, presence: true
  validates :edition_number, numericality: { only_integer: true, greater_than: 0 }, allow_nil: false
  validates :number_of_pages, numericality: { only_integer: true, greater_than: 0 }, allow_nil: false
  validates :publication_year, numericality: { only_integer: true, greater_than: 0 }, allow_nil: false
end
