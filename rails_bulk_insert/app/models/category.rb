class Category < ApplicationRecord
  enum code: {
    fiction: "fiction",
    history: "history",
    art:     "art",
    cooking: "cooking",
  }

  # Associations
  has_many :books

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :description, presence: true
end
