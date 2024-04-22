create table Games (
    id int auto_increment primary key,
    title varchar(50),
    company varchar(50),
    type varchar(30),
    production_year int,
    production_cost int,
    revenue int,
    rating int
);

INSERT INTO Games (title, company, type, production_year, production_cost, revenue, rating) VALUES
('Assassin''s Creed: Brotherhood', 'Ubisoft', 'Action-adventure', 2010, 80000000, 300000, 8),
('Portal 2', 'Valve Corporation', 'Sandbox', 2011, 50000000, 200000, 9),
('The Elder Scrolls V: Skyrim', 'Ubisift', 'Action RPG', 2011, 100000000, 500000000, 9),
('Batman: Arkham City', 'Rocksteady Studios', 'Action-adventure', 2011, 120000000, 250000000, 9),
('The Last of Us', 'Rockstar Games', 'Action-adventure', 2013, 60000000, 2500000, 10),
('Cyberpunk 2077', 'CD Projekt Red', 'Action RPG', 2020, 150000000, 2500000, 7),
('Red Dead Redemption 2', 'Rockstar Games', 'Action-adventure', 2018, 20000000, 725000000, 9),
('Minecraft', 'Epic Games', 'Sandbox', 2011, 5000000, 400000000, 9),
('Fortnite', 'Epic Games', 'Battle Royale', 2017, 10000000, 2000000000, 8),
('FIFA 21', 'Ubisoft', 'Sports', 2020, 80000000, 450000000, 7),
('Call of Duty: Warzone', 'Epic Games', 'Battle Royale', 2020, 75000000, 700000000, 8),
('Among Us', 'Rockstar Games', 'Party', 2018, 1000000, 50000000, 9),
('League of Legends', 'Epic Games', 'MOBA', 2009, 5000000, 1000000000, 10),
('Super Mario Odyssey', 'Epic Games', 'Platformer', 2017, 80000000, 550000, 9);

-- 3
select * from Games order by production_cost asc, rating desc;

-- 4
select * from Games
where production_year >= 2010 and production_year <= 2015 and rating > 7
order by production_year asc;

-- 5
select 
    production_year,
    count(*) as count,
    avg(production_cost) as avg_cost,
    avg(revenue) as avg_revenue
from Games
group by 
    production_year;

-- 6
select
    company,
    count(*) as number_of_games
from Games
where
    production_cost < revenue
group by
    company;

-- 7
select
    company,
    count(*) as number_of_games,
    avg(production_cost) as avg_cost
from Games
group by
    company
having
    count(*) > 1;
