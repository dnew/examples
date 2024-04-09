require 'csv'

namespace :db do
  desc 'Import or upsert books, authors, and publishers from a CSV file without preloading all records'
  task import_csv: [:environment] do |t, args|

    column_map = {
      book_isbn: 0,
      book_title: 1,
      book_number_of_pages: 2,
      book_edition_number: 3,
      book_publication_date: 4,
      author_isan: 5,
      author_first_name: 6,
      author_last_name: 7,
      publisher_ispn: 8,
      publisher_name: 9,
      publisher_country_of_origin: 10,
      publisher_founded_at: 11,
      category_code: 12
    }

    file_path = args.extras.first || 'lib/tasks/import_data.csv'

    books_to_import = []
    authors_to_import = []
    publishers_to_import = []

    existing_categories = Category.all.index_by(&:code)

    csv_data = File.open(file_path, 'r:ISO-8859-1')

    csv_data.each_line do |line|
      # We're assuming all data is present and valid for now.
      row = line.split(',')

      books_to_import << Book.new(
        isbn:             row[column_map[:book_isbn]            ],
        title:            row[column_map[:book_title]           ],
        number_of_pages:  row[column_map[:book_number_of_pages] ],
        edition_number:   row[column_map[:book_edition_number]  ],
        publication_date: row[column_map[:book_publication_date]],
        author_isan:      row[column_map[:author_isan]          ],
        publisher_ispn:   row[column_map[:publisher_ispn]       ],
        category_code:    row[column_map[:category_code]        ]
      )

      authors_to_import << Author.new(
        isan:       row[column_map[:author_isan]      ],
        first_name: row[column_map[:author_first_name]],
        last_name:  row[column_map[:author_last_name] ]
      )

      publishers_to_import << Publisher.new(
        ispn:              row[column_map[:publisher_ispn]             ],
        name:              row[column_map[:publisher_name]             ],
        country_of_origin: row[column_map[:publisher_country_of_origin]],
        founded_at:        row[column_map[:publisher_founded_at]       ]
      )
    end

    # Upsert authors and publishers
    Author.import authors_to_import, on_duplicate_key_update: {
      conflict_target: [:isan],
      columns: [:first_name, :last_name]
    }

    Publisher.import publishers_to_import, on_duplicate_key_update: {
      conflict_target: [:ispn],
      columns: [:name, :country_of_origin, :founded_at]
    }

    Book.import books_to_import, on_duplicate_key_update: {
      conflict_target: [:isbn],
      columns: [:title, :number_of_pages, :edition_number, :publication_date, :author_id, :publisher_id, :category_id]
    }

    puts "Data import process completed."
  end
end
