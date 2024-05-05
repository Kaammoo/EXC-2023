create database Movie;
use Movie;

create table Directors (
    id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100)
);

create table Actors (
    id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    phone_number varchar(20)
);

create table Movies (
    id int auto_increment primary key,
    title varchar(100),
    description varchar(255),
    publication_year int,
    duration int,
    country varchar(50)
);

create table Genres (
    id int auto_increment primary key,
    genre varchar(50)
);

create table Directors_info (
    director_id int,
    movie_id int,
    foreign key (director_id) references Directors(id),
    foreign key (movie_id) references Movies(id)
);

create table Actors_info (
    actor_id int,
    movie_id int,
    foreign key (actor_id) references Actors(id),
    foreign key (movie_id) references Movies(id)
);

create table Movies_info (
    movie_id int,
    genre_id int,
    foreign key (movie_id) references Movies(id),
    foreign key (genre_id) references Genres(id)
);
