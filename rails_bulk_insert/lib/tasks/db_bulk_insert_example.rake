namespace :db do
  desc "Bulk insert books, authors, and publishers using upsert_all"
  task bulk_insert: :environment do

    # Prentend we're reading this data from a CSV file
    authors_to_insert = {}


    # We're deduplicating the data because PostgreSQL does not handle duplicate keys as documented for upsert_all.
    # See: https://github.com/rails/rails/issues/35519
    authors_to_insert['A-0001'] = {
      isan: 'A-0001',
      first_name: 'F. Scott',
      last_name: 'Fitzgerald'
    }
    authors_to_insert['A-0002'] = {
      isan: 'A-0002',
      first_name: 'J.D.',
      last_name: 'Salinger'
    }
    authors_to_insert['A-0001'] = {
      isan: 'A-0001',
      first_name: 'F. Scott',
      last_name: 'Fitzgerald'
    }
    authors_to_insert['A-0002'] = {
      isan: 'A-0002',
      first_name: 'J.D.',
      last_name: 'Salinger'
    }

    publishers_to_insert = {}
    publishers_to_insert['P-0001'] = {
      ispn: 'P-0001',
      name: 'Charles Scribner\'s Sons',
      country_of_origin: 'United States',
      founded_at: Date.new(1846, 1, 1)
    }
    publishers_to_insert['P-0002'] = {
      ispn: 'P-0002',
      name: 'Little, Brown and Company',
      country_of_origin: 'United States',
      founded_at: Date.new(1837, 1, 1)
    }
    publishers_to_insert['P-0001'] = {
      ispn: 'P-0001',
      name: 'Charles Scribner\'s Sons',
      country_of_origin: 'United States',
      founded_at: Date.new(1846, 1, 1)
    }
    publishers_to_insert['P-0002'] = {
      ispn: 'P-0002',
      name: 'Little, Brown and Company',
      country_of_origin: 'United States',
      founded_at: Date.new(1837, 1, 1)
    }

    books_to_insert = {}
    books_to_insert['978-1-56619-909-4'] = {
      isbn: '978-1-56619-909-4',
      title: 'The Great Gatsby',
      number_of_pages: 180,
      edition_number: 1,
      publication_year: 1925,
      author_isan: 'A-0001',
      publisher_ispn: 'P-0001',
      category_code: 'fiction'
    }
    books_to_insert['978-0-307-59431-5'] = {
      isbn: '978-0-307-59431-5',
      title: 'The Catcher in the Rye',
      number_of_pages: 214,
      edition_number: 1,
      publication_year: 1951,
      author_isan: 'A-0002',
      publisher_ispn: 'P-0002',
      category_code: 'fiction'
    }
    books_to_insert['978-1-56619-909-4'] = {
      isbn: '978-1-56619-909-4',
      title: 'The Great Gatsby',
      number_of_pages: 180,
      edition_number: 1,
      publication_year: 1925,
      author_isan: 'A-0001',
      publisher_ispn: 'P-0001',
      category_code: 'fiction'
    }
    books_to_insert['978-0-307-59431-5'] = {
      isbn: '978-0-307-59431-5',
      title: 'The Catcher in the Rye',
      number_of_pages: 214,
      edition_number: 1,
      publication_year: 1951,
      author_isan: 'A-0002',
      publisher_ispn: 'P-0002',
      category_code: 'fiction'
    }

    print "Inserting authors..."
    Author.upsert_all authors_to_insert.values, unique_by: :isan
    puts "done"

    print "Inserting publishers..."
    Publisher.upsert_all publishers_to_insert.values, unique_by: :ispn
    puts "done"

    print "Inserting books..."
    Book.upsert_all books_to_insert.values, unique_by: :isbn, update_only: [:title]
    puts "done"
  end
end
