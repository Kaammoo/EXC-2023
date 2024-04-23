create table Games (
    id int auto_increment primary key,
    title varchar(20),
    company varchar(20),
    type varchar(20),
    production_year int,
    production_cost int,
    revenue int,
    rating int);

insert into Games (title, company, type, production_year, production_cost, revenue, rating) values
    ('The Witcher 3', 'CD Projekt Red', 'RPG', 2015, 80000000, 450000, 9),
    ('Grand Theft Auto V', 'Rockstar Games', 'Action', 2013, 137000000, 600000, 10),
    ('Red Dead Redemption', 'Rockstar Games', 'Action', 2018, 75000000, 725000, 10),
    ('The Last of Us', 'Naughty Dog', 'Action', 2020, 100000000, 400000000, 9),
    ('Minecraft', 'Mojang Studios', 'Sandbox', 2011, 2000000, 2000000000, 9),
    ('Fortnite', 'Epic Games', 'Battle Royale', 2017, 100000000, 1000000000, 8),
    ('League of Legends', 'Riot Games', 'MOBA', 2009, 15000000, 2000000000, 9),
    ('Call of Duty', 'Infinity Ward', 'Shooter', 2019, 250000000, 800000000, 9),
    ('FIFA 21', 'EA Sports', 'Sport', 2020, 80000000, 700000000, 8),
    ('Among Us', 'Innersloth', 'Party', 2018, 1000000, 60000000, 8),
    ('The Legend of Zelda', 'Nintendo', 'Action-adventure', 2017, 150000000, 1000000000, 10),
    ('Overwatch', 'Bizard Entertainment', 'Hero Shooter', 2016, 40000000, 1000000000, 9),
    ('Cyberpunk 2077', 'CD Projekt Red', 'RPG', 2020, 300000000, 500000, 7),
    ('Halo Infinite', '343 Industries', 'Shooter', 2021, 500000000, 600000000, 8),
    ('Animal Crossing', 'Nintendo', 'Life simulation', 2020, 200000000, 800000000, 9);

select * from Games order by production_cost asc, rating desc;

select production_cost from Games 
where production_year between 2010 and 2015 
    and rating > 7 
    order by production_cost asc;

select production_year, 
    count(*) as Count, 
    avg(production_cost) as avg_cost, 
    avg(revenue) as avg_revenue 
    from Games 
    group by production_year;

select type, company, 
    count(*) as number_of_games 
    from Games 
    where revenue > production_cost 
    group by company, type;

select company,
    count(*) as number_of_games,
    avg(production_cost) as avg_cost
    from Games
    group by company
    having number_of_games > 1;
