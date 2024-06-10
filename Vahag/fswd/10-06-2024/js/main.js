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

// User class implementation

class User {
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

const book1 = new Book("1984", "George Orwell", "Dystopian", "9780451524935");
const book2 = new Book(
  "To Kill a Mockingbird",
  "Harper Lee",
  "Fiction",
  "9780061120084"
);
const book3 = new Book(
  "The Great Gatsby",
  "F. Scott Fitzgerald",
  "Classics",
  "9780743273565"
);

const user1 = new User("Alice", "12345");
const user2 = new User("Bob", "54321");
const user3 = new User("Charlie", "98765");

var library = new Library([book1, book2, book3], [user1, user2, user3]);

function displayAvailableBooks(books) {
  const availableBooks = document.getElementById("available-books");

  availableBooks.innerHTML = "";

  books.forEach((book) => {
    const listItem = document.createElement("li");
    listItem.textContent = `${book.title} by ${book.author} (${book.isbn})`;
    availableBooks.appendChild(listItem);
  });
}

function displayRegisteredUsers(users) {
  const registeredUsers = document.getElementById("registered-users");

  registeredUsers.innerHTML = "";

  users.forEach((user) => {
    const listItem = document.createElement("li");
    if (user.getBooks().length === 0) {
      listItem.textContent = `${user.id}: ${user.name}, has not borrowed any books.`;
    } else {
      const borrowedBooks = user
        .getBooks()
        .map((book) => book.title)
        .join(", ");
      listItem.textContent = `${user.id}: ${user.name}, borrowed books: ${borrowedBooks}`;
    }
    registeredUsers.appendChild(listItem);
  });
}

function borrowBook(user, book) {
  library.handBook(book);
  user.borrowBooks(book);
}

function addNewBook(title, author, genre, isbn) {
  const book = new Book(title, author, genre, isbn);
  library.addBooks(book);
  displayAvailableBooks(library.getBooks());
}

function registerNewUser(name, id) {
  const user = new User(name, id);
  library.registerUser(user);
  displayRegisteredUsers(library.getUsers());
}

document.addEventListener("DOMContentLoaded", function () {
  const userForm = document.getElementById("add-user-form");

  userForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const userName = document.getElementById("user-name").value;
    const userId = document.getElementById("user-id").value;

    if (userName && userId) {
      if (library.getUsers().some((user) => user.id === userId)) {
        alert("User with this ID already exists!");
      } else {
        registerNewUser(userName, userId);
      }
    }

    userForm.reset();
  });
});

window.onload = () => {
  displayAvailableBooks(library.getBooks());
  displayRegisteredUsers(library.getUsers());
};
