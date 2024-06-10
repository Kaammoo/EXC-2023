// Library class implementation

class Library {
  constructor(books, users) {
    this.books = books;
    this.users = users;
  }

  addBooks(books) {
    if (Array.isArray(books)) {
      this.books.push(...books);
    } else {
      this.books.push(books);
    }
  }

  handBook(book) {
    this.books = this.books.filter((b) => b !== book);
  }

  registerUser(users) {
    // can i write this more optimally?
    if (Array.isArray(users)) {
      this.users.push(...users);
    } else {
      this.users.push(users);
    }
  }

  getBooks() {
    return this.books;
  }

  getUsers() {
    return this.users;
  }
}
