namespace :db do
  desc "Print all books in table format"
  task print_books: :environment do
    books = Book.all

    if books.empty?
      puts "No books found."
    else
      header = ["ISBN", "Title", "Author", "Publisher", "Category", "Pages", "Publication Year"]
      rows = books.map do |book| [
        book.isbn,
        book.title,
        "#{book.author.first_name} #{book.author.last_name}",
        book.publisher.name,
        book.category.name,
        book.number_of_pages,
        book.publication_year]
      end

      puts header.join("\t")
      puts "-" * 100
      rows.each { |row| puts row.join("\t") }
    end
  end
end
