create table movies (
    id int primary key,
    title varchar(100),
    description varchar(100),
    production_date date,
    rating float
);

create table genres (
    id int primary key,
    name varchar(100)
);

create table person (
    id int primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100)
);

create table movie_crew (
    movie_id int,
    person_id int,
    job varchar(100),
    foreign key (movie_id) references movies(id),
    foreign key (person_id) references person(id),
    primary key (movie_id, person_id)
);

create table movie_genres (
    genre_id int,
    movie_id int,
    foreign key (genre_id) references genres(id),
    foreign key (movie_id) references movies(id),
    primary key (genre_id, movie_id)
);

create table production_company (
    id int primary key,
    company varchar(100)
);

create table movie_company (
    movie_id int,
    company_id int,
    foreign key (movie_id) references movies(id),
    foreign key (company_id) references production_company(id),
    primary key (movie_id, company_id)
);

