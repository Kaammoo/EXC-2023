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
      isbn: this.isbn
    };
  }

  checkAvailability() {
    return this.availability;
  }

  borrowBook() {
    this.availability = false;
  }

  returnBook() {
    this.availability = true;
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

  returnBook(book) {
    this.books = this.books.filter(b => b.isbn !== book.isbn);
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
    this.books = this.books.filter(b => b.isbn !== book.isbn);
  }

  registerUser(users) {
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

const book1 = new Book('1984', 'George Orwell', 'Dystopian', '9780451524935');
const book2 = new Book(
  'To Kill a Mockingbird',
  'Harper Lee',
  'Fiction',
  '9780061120084'
);
const book3 = new Book(
  'The Great Gatsby',
  'F. Scott Fitzgerald',
  'Classics',
  '9780743273565'
);

const user1 = new User('Alice', '12345');
const user2 = new User('Bob', '54321');
const user3 = new User('Charlie', '98765');

var library = new Library([book1, book2, book3], [user1, user2, user3]);

function displayAvailableBooks(books) {
  const availableBooks = document.getElementById('available-books');

  availableBooks.innerHTML = '';

  books.forEach(book => {
    if (book.checkAvailability()) {
      const listItem = document.createElement('li');
      listItem.textContent = `${book.title} by ${book.author} (${book.isbn})`;
      availableBooks.appendChild(listItem);
    }
  });
}

function displayRegisteredUsers(users) {
  var registeredUsers = document.getElementById('registered-users');

  registeredUsers.innerHTML = '';

  users.forEach(user => {
    const listItem = document.createElement('li');
    if (user.getBooks().length === 0) {
      listItem.textContent = `${user.id}: ${user.name}, has not borrowed any books.`;
    } else {
      const borrowedBooks = user
        .getBooks()
        .map(book => book.title)
        .join(', ');
      listItem.textContent = `${user.id}: ${user.name}, borrowed books: ${borrowedBooks}`;
    }
    registeredUsers.appendChild(listItem);
  });
}

function borrowBook(user, book) {
  if (book.checkAvailability()) {
    book.borrowBook();
    user.borrowBooks(book);
    library.handBook(book);
    displayAvailableBooks(library.getBooks());
    displayRegisteredUsers(library.getUsers());
  } else {
    alert('The book is not available.');
  }
}

function returnBook(user, book) {
  book.returnBook();
  user.returnBook(book);
  library.addBooks(book);
  displayAvailableBooks(library.getBooks());
  displayRegisteredUsers(library.getUsers());
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

function displaySearchedBooks(books, elemId) {
  const resultsList = document.getElementById(elemId);

  resultsList.innerHTML = '';

  books.forEach(book => {
    const listItem = document.createElement('li');
    listItem.textContent = `${book.title} by ${book.author} (${book.isbn})`;
    resultsList.appendChild(listItem);
  });
}

document.addEventListener('DOMContentLoaded', function () {
  const userForm = document.getElementById('add-user-form');
  const bookForm = document.getElementById('add-book-form');
  const borrowForm = document.getElementById('borrow-form');
  const returnForm = document.getElementById('return-form');
  const searchForm = document.getElementById('search-form');
  const searchGenreForm = document.getElementById('search-genre-form');

  userForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const userName = document.getElementById('user-name').value;
    const userId = document.getElementById('user-id').value;

    if (userName && userId) {
      if (library.getUsers().some(user => user.id === userId)) {
        alert('User with this ID already exists!');
      } else {
        registerNewUser(userName, userId);
        userForm.reset();
        displayRegisteredUsers(library.getUsers());
        createUsersOptions(library.getUsers());
      }
    }
  });

  bookForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const bookTitle = document.getElementById('book-title').value;
    const bookAuthor = document.getElementById('book-author').value;
    const bookGenre = document.getElementById('book-genre').value;
    const bookISBN = document.getElementById('book-isbn').value;

    if (bookTitle && bookAuthor && bookGenre && bookISBN) {
      if (library.getBooks().some(book => book.isbn === bookISBN)) {
        alert('Book with this ISBN already exists!');
      } else {
        addNewBook(bookTitle, bookAuthor, bookGenre, bookISBN);
        bookForm.reset();
        displayAvailableBooks(library.getBooks());
        createBooksOptions(library.getBooks());
      }
    }
  });

  borrowForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const userId = document.getElementById('user').value;
    const bookISBN = document.getElementById('book').value;

    const user = library.getUsers().find(user => user.id === userId);
    const book = library.getBooks().find(book => book.isbn === bookISBN);

    if (user && book) {
      borrowBook(user, book);
      displayAvailableBooks(library.getBooks());
      displayRegisteredUsers(library.getUsers());
      createBooksOptions(library.getBooks());
      createReturnUsersOptions(library.getUsers());
    } else {
      alert('User or book not found, or the book is not available!');
    }
  });

  returnForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const userId = document.getElementById('user-return').value;
    const bookISBN = document.getElementById('book-return').value;

    const user = library.getUsers().find(user => user.id === userId);
    const book = user.getBooks().find(book => book.isbn === bookISBN);

    if (user && book) {
      returnBook(user, book);
      displayAvailableBooks(library.getBooks());
      displayRegisteredUsers(library.getUsers());
      createBooksOptions(library.getBooks());
      createReturnUsersOptions(library.getUsers());
    } else {
      alert('User or book not found!');
    }
  });

  searchForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const input = document.getElementById('search-query');
    searchBooks(input);
  });

  searchGenreForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const input = document.getElementById('search-genre');
    searchBooksByGenre(input);
  });

  function searchBooksByGenre(input) {
    const query = input.value.toLowerCase();
    const books = library.getBooks();

    const searchedBooks = books.filter(book => {
      return book.genre.toLowerCase().includes(query);
    });

    displaySearchedBooks(searchedBooks, 'genre-list');
  }

  function searchBooks(input) {
    const query = input.value.toLowerCase();
    const books = library.getBooks();

    const searchedBooks = books.filter(book => {
      const titleMatch = book.title.toLowerCase().includes(query);
      const authorMatch = book.author.toLowerCase().includes(query);
      return titleMatch || authorMatch;
    });

    displaySearchedBooks(searchedBooks, 'results-list');
  }

  function createUsersOptions(users) {
    const userLabel = document.getElementById('user');
    userLabel.innerHTML = '';

    users.forEach(user => {
      const option = document.createElement('option');
      option.value = user.id;
      option.textContent = user.name;

      userLabel.appendChild(option);
    });
  }

  function createBooksOptions(books) {
    const bookLabel = document.getElementById('book');
    bookLabel.innerHTML = '';

    books.forEach(book => {
      if (book.checkAvailability()) {
        const option = document.createElement('option');
        option.value = book.isbn;
        option.textContent = `${book.title} by ${book.author}`;

        bookLabel.appendChild(option);
      }
    });
  }

  function createReturnUsersOptions(users) {
    const userLabel = document.getElementById('user-return');

    userLabel.innerHTML = '';

    users.forEach(user => {
      if (user.getBooks().length > 0) {
        const option = document.createElement('option');
        option.value = user.id;
        option.textContent = user.name;

        userLabel.appendChild(option);
      }
    });

    userLabel.addEventListener('change', function () {
      const selectedUser = users.find(user => user.id === this.value);
      createReturnBooksOptions(selectedUser ? selectedUser.getBooks() : []);
    });

    userLabel.dispatchEvent(new Event('change'));
  }

  function createReturnBooksOptions(books) {
    const bookLabel = document.getElementById('book-return');

    bookLabel.innerHTML = '';

    books.forEach(book => {
      const option = document.createElement('option');
      option.value = book.isbn;
      option.textContent = `${book.title} by ${book.author}`;

      bookLabel.appendChild(option);
    });
  }

  createUsersOptions(library.getUsers());
  createBooksOptions(library.getBooks());
  createReturnUsersOptions(library.getUsers());
});

window.onload = () => {
  displayAvailableBooks(library.getBooks());
  displayRegisteredUsers(library.getUsers());
};
