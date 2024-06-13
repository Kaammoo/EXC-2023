// User class implementation

export class User {
  constructor(name, id, books = []) {
    this.name = name;
    this.id = id;
    this.books = books;
  }

  borrowBooks(books) {
    if (Array.isArray(books)) {
      this.books.push(...books);
    } else {
      this.books.push(books);
    }
  }

  getBooks() {
    return this.books;
  }
}
