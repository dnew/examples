namespace :db do
  desc "Intentionally cause a deadlock error"
  task deadlock_example: :environment do
    threads = []

    puts "Starting deadlock example."

    threads << Thread.new do
      puts "Starting thead 1"

      ActiveRecord::Base.transaction do
        Author.upsert(
          {
            isan: 'A-9999',
            first_name: 'Otto',
            last_name: 'Von Deadlock'
          }
        )

        sleep 1

        # Create or update publisher
        Publisher.upsert(
          {
            ispn: 'P-9999',
            name: 'Deadlock Publishing',
            country_of_origin: 'United States',
            founded_at: Date.new(2020, 1, 1)
          }
        )

        sleep 1

        Book.upsert(
          {
            isbn: 'D-0001',
            title: 'Deadlocks for Dummies',
            edition_number: 1,
            publication_year: 2020,
            number_of_pages: 999,
            author_isan: 'A-9999',
            publisher_ispn: 'P-9999',
            category_code: 'non-fiction'
          }
        )
      end

      puts "Thread 1 finished"
    end

    threads << Thread.new do
      puts "Starting thead 2"

      ActiveRecord::Base.transaction do
        Publisher.upsert(
          {
            ispn: 'P-9999',
            name: 'Deadlock Publishing',
            country_of_origin: 'United States',
            founded_at: Date.new(2020, 1, 1)
          }
        )

        sleep 1

        Author.upsert(
          {
            isan: 'A-9999',
            first_name: 'Otto',
            last_name: 'Von Deadlock'
          }
        )

        sleep 1

        Book.upsert(
          {
            isbn: 'D-0001',
            title: 'Deadlocks for Dummies',
            edition_number: 1,
            publication_year: 2020,
            number_of_pages: 10000,
            author_isan: 'A-9999',
            publisher_ispn: 'P-9999',
            category_code: 'non-fiction'
          }
        )
      end

      puts "Thread 2 finished"
    end

    threads.each(&:join)

    puts "All threads finished"
  end
end
