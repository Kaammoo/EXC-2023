// Task 1
const books = [
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    genre: "Fiction",
    date: "1960-07-11",
    pages: 281,
  },
  {
    title: "1984",
    author: "George Orwell",
    genre: "Dystopian",
    date: "1949-06-08",
    pages: 328,
  },
  {
    title: "Moby-Dick",
    author: "Herman Melville",
    genre: "Adventure",
    date: "1851-10-18",
    pages: 635,
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    genre: "Romance",
    date: "1813-01-28",
    pages: 279,
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    genre: "Tragedy",
    date: "1925-04-10",
    pages: 180,
  },
  {
    title: "War and Peace",
    author: "Leo Tolstoy",
    genre: "Historical",
    date: "1869-01-01",
    pages: 1225,
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    genre: "Fiction",
    date: "1951-07-16",
    pages: 214,
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    genre: "Fantasy",
    date: "1937-09-21",
    pages: 310,
  },
  {
    title: "Brave New World",
    author: "Aldous Huxley",
    genre: "Science Fiction",
    date: "1932-01-01",
    pages: 268,
  },
  {
    title: "Jane Eyre",
    author: "Charlotte Brontë",
    genre: "Romance",
    date: "1847-10-16",
    pages: 500,
  },
  {
    title: "Lav girq",
    author: "Charlotte Brontë",
    genre: "Fantasy",
    date: "1947-11-06",
    pages: 700,
  },
  {
    title: "Mardaspan pahaky",
    author: "Aldous Huxley",
    genre: "Horror",
    date: "2003-07-16",
    pages: 1250,
  },
];

function getBooks() {
  displayResult(books);
}

// Task 2
function getBookTitle() {
  const titles = [];
  for (const title of books) {
    titles.push(title.title);
  }
  displayResult(titles);
}

// Task 3
function getTotalNumberOfPages() {
  const total = books.reduce((total, book) => total + book.pages, 0);
  displayResult(total);
}

// Task 4
function getBookWithMaxPages() {
  const bookWithMaxPages = books.reduce((previous, current) => {
    return previous.pages > current.pages ? previous : current;
  });
  displayResult(bookWithMaxPages);
}

// Task 5
function getBookWithMinTitle() {
  const bookWithMinTitle = books.reduce((previous, current) => {
    return previous.title.length < current.title.length ? previous : current;
  });
  displayResult(bookWithMinTitle);
}

// Task 6
function getAuthors() {
  const authors = new Set(books.map((author) => author.author));
  const uniqueAuthors = [...authors];
  displayResult(uniqueAuthors);
}

// Task 7
function getAuthorsWithBooks() {
  let authors = [];

  for (let i = 0; i < books.length; ++i) {
    let name = books[i].author;
    let title = books[i].title;
    let index = authors.findIndex((author) => author.name === name);

    if (index == -1) {
      authors.push({
        name: name,
        books: [title],
      });
    } else {
      authors[index].books.push(title);
    }
  }
  displayResult(authors);
}

function displayResult(result) {
  const outputDiv = document.getElementById("output");
  outputDiv.innerHTML = JSON.stringify(result, null, 2);
}

function clearDisplayResult() {
  const outputDiv = document.getElementById("output");
  outputDiv.innerHTML = "";
}
