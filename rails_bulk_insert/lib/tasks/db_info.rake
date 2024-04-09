namespace :db do
  desc "Outputs diagnostic info about the records in the database"
  task info: :environment do
    puts "Authors: #{Author.count}"
    puts "Publishers: #{Publisher.count}"
    puts "Categories: #{Category.count}"
    puts "Books: #{Book.count}"
  end
end
