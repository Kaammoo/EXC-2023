// Book class implementation

class Book {
  constructor(title, author, genre, isbn) {
    this.title = title;
    this.author = author;
    this.genre = genre;
    this.isbn = isbn;
    this.availability = true;
  }

  getBookDetails() {
    return {
      title: this.title,
      author: this.author,
      genre: this.genre,
      isbn: this.isbn,
    };
  }

  checkAvailability() {
    return this.availability;
  }

  borrowBook() {
    this.availability = false;
  }
}
