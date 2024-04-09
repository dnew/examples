class Publisher < ApplicationRecord
  # Associations
  has_many :books

  # Validations

  # International Standard Publisher Number (ISPN) is a unique identifier for publishers.
  validates :ispn, presence: true, uniqueness: true
  validates :name, presence: true
  validates :country_of_origin, presence: true
  validates :founded_at, presence: true
end
