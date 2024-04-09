# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
print "Clearing existing data..."

[Book, Author, Publisher, Category].each(&:delete_all)

puts "done!"

# Preload data

# Science Fiction Authors
authors = [
  {
    isan: 'A-0000',
    first_name: 'Isaac',
    last_name: 'Asimov'
  },
  {
    isan: 'A-0001',
    first_name: 'Arthur C.',
    last_name: 'Clarke'
  },
  {
    isan: 'A-0002',
    first_name: 'Philip K.',
    last_name: 'Dick'
  },
  {
    isan: 'A-0003',
    first_name: 'William',
    last_name: 'Gibson'
  }
]

# Publishers
publishers = [
  {
    ispn: 'P-0000',
    name: 'Penguin Random House',
    founded_at: Date.new(1935, 7, 1),
    country_of_origin: 'United States'
  },
  {
     ispn: 'P-0001',
     name: 'HarperCollins',
     founded_at: Date.new(1817, 6, 26),
     country_of_origin: 'United States'
  },
  {
     ispn: 'P-0002',
     name: 'Simon & Schuster',
     founded_at: Date.new(1924, 4, 1),
     country_of_origin: 'United States'
  },
  {
    ispn: 'P-0003',
    name: 'Macmillan Publishers',
    founded_at: Date.new(1843, 10, 16),
    country_of_origin: 'United Kingdom'
  }
]

# Categories
categories = [
  {
    code: "fiction",
    name: "Fiction",
    description: "Imaginative or invented stories, especially those of a writer of prose fiction."
  },
  {
    code: "history",
    name: "History",
    description: "The study of past events, particularly in human affairs."
  },
  {
    code: "art",
    name: "Art",
    description: "The expression or application of human creative skill and imagination."
  },
  {
    code: "cooking",
    name: "Cooking",
    description: "The practice or skill of preparing food by combining, mixing, and heating ingredients."
  }
]

books = [
  {
    isbn: '9780553803709',
    title: 'I, Robot',
    edition_number: 1,
    publication_year: 1950,
    number_of_pages: 224,
    author_isan: 'A-0000',
    publisher_ispn: 'P-0000',
    category_code: 'fiction',
  },
  {
    isbn: '9780553293357',
    title: '2001: A Space Odyssey',
    edition_number: 1,
    publication_year: 1968,
    number_of_pages: 336,
    author_isan: 'A-0001',
    publisher_ispn: 'P-0001',
    category_code: 'fiction',
  },
  {
    isbn: '9780345342966',
    title: 'Childhood\'s End',
    edition_number: 1,
    publication_year: 1953,
    number_of_pages: 224,
    author_isan: 'A-0001',
    publisher_ispn: 'P-0002',
    category_code: 'fiction',
  },
  {
    isbn: '9780345404473',
    title: 'Do Androids Dream of Electric Sheep?',
    edition_number: 1,
    publication_year: 1968,
    number_of_pages: 224,
    author_isan: 'A-0002',
    publisher_ispn: 'P-0003',
    category_code: 'fiction',
  },
  {
    isbn: '9780441569595',
    title: 'Neuromancer',
    edition_number: 1,
    publication_year: 1984,
    number_of_pages: 320,
    author_isan: 'A-0003',
    publisher_ispn: 'P-0000',
    category_code: 'fiction',
  }
]

# Create records
print "Creating authors..."
authors.each { |author| Author.create!(author) }
puts "done!"

print "Creating publishers..."
publishers.each { |publisher| Publisher.create!(publisher) }
puts "done!"

print "Creating categories..."
categories.each { |category| Category.create!(category) }
puts "done!"

print "Creating books..."
books.each { |book| Book.create!(book) }
puts "done!"

# Output Stats
puts "Authors: #{Author.count}"
puts "Publishers: #{Publisher.count}"
puts "Categories: #{Category.count}"
