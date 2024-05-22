-- Table: Movie
CREATE TABLE Movie (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    ReleaseDate DATE,
    Genre VARCHAR(50),
    Director VARCHAR(100)
);

-- Table: Actor
CREATE TABLE Actor (
    ActorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    BirthDate DATE
);

-- Table: Role
CREATE TABLE Role (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    MovieID INT,
    ActorID INT,
    CharacterName VARCHAR(100),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)
);

-- Table: Review
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    MovieID INT,
    ReviewerName VARCHAR(100),
    Rating DECIMAL(3, 1),
    ReviewText TEXT,
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);
-- Insert sample data into the Movie table
INSERT INTO Movie (Title, ReleaseDate, Genre, Director) VALUES
    ('Inception', '2010-07-16', 'Science Fiction', 'Christopher Nolan'),
    ('The Shawshank Redemption', '1994-09-23', 'Drama', 'Frank Darabont'),
    ('The Godfather', '1972-03-24', 'Crime', 'Francis Ford Coppola'),
    ('Pulp Fiction', '1994-10-14', 'Crime', 'Quentin Tarantino'),
    ('The Dark Knight', '2008-07-18', 'Action', 'Christopher Nolan'),
    ('Forrest Gump', '1994-07-06', 'Drama', 'Robert Zemeckis'),
    ('Fight Club', '1999-10-15', 'Drama', 'David Fincher'),
    ('The Matrix', '1999-03-31', 'Science Fiction', 'The Wachowskis'),
    ('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Fantasy', 'Peter Jackson'),
    ('The Silence of the Lambs', '1991-02-14', 'Thriller', 'Jonathan Demme');

-- Insert sample data into the Actor table
INSERT INTO Actor (Name, BirthDate) VALUES
    ('Leonardo DiCaprio', '1974-11-11'),
    ('Morgan Freeman', '1937-06-01'),
    ('Marlon Brando', '1924-04-03'),
    ('John Travolta', '1954-02-18'),
    ('Christian Bale', '1974-01-30'),
    ('Tom Hanks', '1956-07-09'),
    ('Brad Pitt', '1963-12-18'),
    ('Keanu Reeves', '1964-09-02'),
    ('Elijah Wood', '1981-01-28'),
    ('Anthony Hopkins', '1937-12-31');

-- Insert sample data into the Role table
INSERT INTO Role (MovieID, ActorID, CharacterName) VALUES
    (1, 1, 'Cobb'),
    (2, 2, 'Ellis Boyd "Red" Redding'),
    (3, 3, 'Don Vito Corleone'),
    (4, 4, 'Vincent Vega'),
    (5, 5, 'Bruce Wayne / Batman'),
    (6, 6, 'Forrest Gump'),
    (7, 7, 'Tyler Durden'),
    (8, 8, 'Neo'),
    (9, 9, 'Frodo Baggins'),
    (10, 10, 'Dr. Hannibal Lecter');

-- Insert sample data into the Review table
INSERT INTO Review (MovieID, ReviewerName, Rating, ReviewText) VALUES
    (1, 'MovieBuff123', 9.5, 'Amazing movie with mind-bending plot twists.'),
    (2, 'CinemaFanatic', 9.7, 'A timeless classic that everyone should watch.'),
    (3, 'CrimeDramaLover', 9.8, 'An epic masterpiece of the crime genre.'),
    (4, 'TarantinoFan', 9.3, 'Quentin Tarantino at his finest.'),
    (5, 'BatmanFanatic', 9.6, 'One of the best superhero movies ever made.'),
    (6, 'TomHanksFan', 9.4, 'Heartwarming and inspirational story.'),
    (7, 'FightClubber', 9.1, 'Mind-blowing and thought-provoking.'),
    (8, 'SciFiGeek', 9.0, 'Revolutionary visual effects and captivating storyline.'),
    (9, 'TolkienFan', 9.9, 'A breathtaking adaptation of J.R.R. Tolkien\'s masterpiece.'),
    (10, 'ThrillerEnthusiast', 9.7, 'Chilling and suspenseful performance by Anthony Hopkins.');

