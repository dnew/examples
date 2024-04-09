class Author < ApplicationRecord
  # Associations
  has_many :books

  # Validations

  # International Standard Author Number (ISAN) is a hypothetical unique identifier for authors.  We use it here as an
  # example of a well known unique identifier that can serve as a foreign key for the books table.
  validates :isan, presence: true, uniqueness: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
