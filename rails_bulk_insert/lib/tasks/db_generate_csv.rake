require 'csv'
require 'faker'

namespace :db do
  desc 'Generate a CSV file with random data for books, authors, and publishers'
  task :generate_csv, [:num_rows] => :environment do |t, args|
    num_rows = args[:num_rows].to_i

    CSV.open('random_data.csv', 'w') do |csv|
      csv << ['Book ISBN', 'Book Title', 'Number of Pages', 'Edition Number', 'Publication Date', 'Author ISAN', 'Author First Name', 'Author Last Name', 'Publisher ISPN', 'Publisher Name', 'Country of Origin', 'Founded At', 'Category Code']

      num_rows.times do
        csv << [
          Faker::Number.unique.number(digits: 13),        # Book ISBN
          Faker::Book.title,                              # Book Title
          Faker::Number.between(from: 1, to: 1000),       # Number of Pages
          Faker::Number.between(from: 1, to: 10),         # Edition Number
          Faker::Date.backward(days: 365 * 50),           # Publication Date
          Faker::Number.unique.number(digits: 13),        # Author ISAN
          Faker::Name.first_name,                         # Author First Name
          Faker::Name.last_name,                          # Author Last Name
          Faker::Number.unique.number(digits: 13),        # Publisher ISPN
          Faker::Book.publisher,                          # Publisher Name
          Faker::Address.country,                         # Country of Origin
          Faker::Date.backward(days: 365 * 50),           # Founded At
          ["fiction", "history", "art", "cooking"].sample # Category Code.
        ]
      end
    end

    puts "CSV file with #{num_rows} rows of random data has been generated."
  end
end
