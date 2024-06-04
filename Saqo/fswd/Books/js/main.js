const books = [
    {
        name: "To Kill a Mockingbird",
        author: "Harper Lee",
        pages: 281,
        image: "https://m.media-amazon.com/images/I/81aY1lxk+9L._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "Go Set a Watchman",
        author: "Harper Lee",
        pages: 278,
        image: "https://m.media-amazon.com/images/I/91YXvPqn5jL._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "1984",
        author: "George Orwell",
        pages: 328,
        image: "https://m.media-amazon.com/images/I/7180qjGSgDL._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "Animal Farm",
        author: "George Orwell",
        pages: 112,
        image: "https://media.licdn.com/dms/image/D4D12AQEuQwzFWMaKUw/article-cover_image-shrink_720_1280/0/1703770100154?e=2147483647&v=beta&t=Di61q9J29XP9ZOOB7aK0CYFHXZDxWK4J6SJBR3p691o"
    },
    {
        name: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        pages: 180,
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKi5lknrw7SIwZ01RQRqyvtXz2bFxrUsGVpA&s"
    },
    {
        name: "One Hundred Years of Solitude",
        author: "Gabriel Garcia Marquez",
        pages: 417,
        image: "https://m.media-amazon.com/images/I/714ZLzX852L._AC_UF894,1000_QL80_.jpg"
    },
    {
        name: "Love in the Time of Cholera",
        author: "Gabriel Garcia Marquez",
        pages: 348,
        image: "https://cdn.penguin.co.uk/dam-assets/books/9780241968567/9780241968567-jacket-large.jpg"
    },
    {
        name: "Pride and Prejudice",
        author: "Jane Austen",
        pages: 279,
        image: "https://m.media-amazon.com/images/M/MV5BMDM0MjFlOGYtNTg2ZC00MmRkLTg5OTQtM2U5ZjUyYTgxZThiXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_.jpg"
    },
    {
        name: "Sense and Sensibility",
        author: "Jane Austen",
        pages: 374,
        image: "https://m.media-amazon.com/images/M/MV5BY2VjYWVmZDctNzA2Yy00YzBmLTliYWEtMjgxYWQwZWU2NjZjXkEyXkFqcGdeQXVyMTEwMTkwOTI@._V1_.jpg"
    },
    {
        name: "Franny and Zooey",
        author: "J.D. Salinger",
        pages: 201,
        image: "https://m.media-amazon.com/images/I/71Okn4m7NBL._AC_UF894,1000_QL80_.jpg"
    },
    {
        name: "Moby-Dick",
        author: "Herman Melville",
        pages: 635,
        image: "https://m.media-amazon.com/images/I/81R91ODA9DL._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "War and Peace",
        author: "Leo Tolstoy",
        pages: 1225,
        image: "https://m.media-amazon.com/images/I/81oHM-dzefL._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "The Odyssey",
        author: "Homer",
        pages: 543,
        image: "https://m.media-amazon.com/images/I/A1JR2oK-orL._AC_UF1000,1000_QL80_.jpg"
    },
    {
        name: "The Iliad",
        author: "Homer",
        pages: 704,
        image: "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1681797700l/77265004.jpg"
    },
];

// Homewrok functions
function getBooksNames() {
    let result = [];
    for (let book of books) {
        result.push(book.name);
    }
    return result;
}

function getAllBooksPagesCount() {
    const totalPages = books.reduce((sum, book) => sum + book.pages, 0);
    return totalPages;
}

function getMaxPagesCountBook() {
    const bookWithMaxPages = books.reduce((maxBook, currentBook) => {
        return (currentBook.pages > maxBook.pages) ? currentBook : maxBook;
    });
    return bookWithMaxPages;
}

function getShortestTitleBook() {
    const shortestTitleBook = books.reduce((shortBook, currentBook) => {
        return (currentBook.name.length < shortBook.name.length) ? currentBook : shortBook;
    });
    return shortestTitleBook;
}

function getAuthors() {
    let authors = new Set();
    for (let book of books) {
        authors.add(book.author);
    }
    return authors;
}

function getAuthorsWithBooks() {
    const authors = books.reduce((acc, book) => {
        if (!acc[book.author]) {
            acc[book.author] = [];
        }
        acc[book.author].push(book.name);
        return acc;
    }, {});
    return authors;
}

// Program functions

function createBookDiv(book) {
    const bookDiv = document.createElement('div');
    bookDiv.classList.add('book');
    const img = document.createElement('img');
    img.src = book.image;
    bookDiv.appendChild(img);
    const bookContentDiv = document.createElement('div');
    bookContentDiv.classList.add('book-content');
    const titleElement = document.createElement('h2');
    titleElement.textContent = book.name;
    const authorElement = document.createElement('span');
    authorElement.textContent = 'Author: ' + book.author;
    const pagesElement = document.createElement('span');
    pagesElement.textContent = 'Pages: ' + book.pages;

    bookContentDiv.appendChild(titleElement);
    bookContentDiv.appendChild(authorElement);
    bookContentDiv.appendChild(pagesElement);

    bookDiv.appendChild(bookContentDiv);

    return bookDiv;
}

function addResultChild(child) {
    result.appendChild(child);
    result.classList.remove('hiden');
}

function createListNames(names) {
    const orderList = document.createElement('ol');
    names.forEach(function (element) {
        const authorElement = document.createElement('li');
        authorElement.textContent = element;
        orderList.appendChild(authorElement);
    })
    return orderList;
}

const booksBox = document.querySelector('.books');

books.forEach(book => {
    const bookDiv = createBookDiv(book);
    booksBox.appendChild(bookDiv);
});

const buttons = document.querySelectorAll('.function-button');
const result = document.querySelector('.result');

function showBookNames() {
    let bookNames = getBooksNames();
    const orderList = createListNames(bookNames);
    addResultChild(orderList);
}

function showSumPages() {
    const sumPagesBox = document.createElement('span');
    let sumPages = getAllBooksPagesCount();
    sumPagesBox.textContent = 'Sum pages: ' + sumPages;
    addResultChild(sumPagesBox);
}

function showBookMaxPage() {
    const book = getMaxPagesCountBook();
    const bookDiv = createBookDiv(book);
    addResultChild(bookDiv);
}

function showShortTitleBook() {
    const book = getShortestTitleBook();
    const bookDiv = createBookDiv(book);
    addResultChild(bookDiv);
}

function showAuthors() {
    let authors = getAuthors();
    const orderList = createListNames(authors);
    addResultChild(orderList);
}

function showAuthorWithBooks() {
    let authorWithBooks = getAuthorsWithBooks();
    for (let authorName in authorWithBooks) {
        const name = document.createElement('h3');
        const delimiter = document.createElement('br');
        name.textContent = authorName;
        const orderList = createListNames(authorWithBooks[authorName]);
        addResultChild(name);
        addResultChild(orderList);
        addResultChild(delimiter);
    }
}

function addBook() {
    const addBox = document.createElement('div')
    addBox.classList.add('addBox');
    const title = document.createElement('input');
    title.classList.add('input-box');
    title.placeholder = 'Book title';
    const authorName = document.createElement('input');
    authorName.classList.add('input-box');
    authorName.placeholder = 'Author name';
    const bookPages = document.createElement('input');
    bookPages.classList.add('input-box');
    bookPages.placeholder = 'Page';
    const bookImage = document.createElement('input');
    bookImage.classList.add('input-box');
    bookImage.placeholder = 'Image';
    const addButton = document.createElement('button');
    addButton.classList.add('function-button');
    addButton.textContent = 'Add';

    addBox.appendChild(title);
    addBox.appendChild(authorName);
    addBox.appendChild(bookPages);
    addBox.appendChild(bookImage);
    addBox.appendChild(addButton);

    addResultChild(addBox);

    addButton.addEventListener('click', function () {
        if (title.value != '' &&
            authorName.value != '' &&
            bookPages.value != '' &&
            bookImage.value != '') {
            let book = {
                name: title.value,
                author: authorName.value,
                pages: bookPages.value,
                image: bookImage.value,
            }
            books.push(book);
            const bookDiv = createBookDiv(book);
            booksBox.appendChild(bookDiv);
            title.value = '';
            authorName.value = '';
            bookPages.value = '';
            bookImage.value = '';
        }
    })
}

function close() {
    result.classList.add('hiden');
    result.innerHTML = '';
}

buttons.forEach(function (item) {
    item.addEventListener('click', function () {
        result.classList.add('hiden');
        result.innerHTML = '';
        switch (item.id) {
            case 'book-names':
                showBookNames();
                break;
            case 'sum-pages':
                showSumPages();
                break;
            case 'max-page':
                showBookMaxPage();
                break;
            case 'short-title':
                showShortTitleBook();
                break;
            case 'authors':
                showAuthors();
                break;
            case 'author-with-books':
                showAuthorWithBooks();
                break;
            case 'close':
                close();
                break;
            case 'add-book':
                addBook();
                break;
            default:
                break;
        }
    })
})