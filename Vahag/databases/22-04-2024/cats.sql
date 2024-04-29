create table Cats (
    id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(20),
    breed varchar(20),
    coloration varchar(20),
    age int,
    fav_toy varchar(20));

insert into Cats (name, breed, coloration, age, fav_toy) values
    ('Whisker', 'Siamese', 'White', 3, 'Feather toy'),
    ('Mittens', 'Maine Coon', 'Tabby', 5, 'Ball of yarn'),
    ('Simba', 'Persian', 'Orange', 2, 'Mouse toy'),
    ('Luna', 'Sphynx', 'Black', 1, 'String toy'),
    ('Oreo', 'Domestic Shorthair', 'Black and White', 4, 'Catnip mouse'),
    ('Gizmo', 'Scottish Fold', 'Gray', 6, 'Squeaky mouse'),
    ('Cleo', 'Bengal', 'Spotted', 2, 'Fuzzy ball'),
    ('Smokey', 'Russian Blue', 'Gray', 7, 'Rope toy'),
    ('Felix', 'Ragdoll', 'Cream', 4, 'Chew stick'),
    ('Loki', 'Norwegian Forest', 'Gray', 3, 'Crinkle ball');

select * from Cats;
select name, breed, coloration from Cats where age <= 5;
select id, name from Cats where breed = "Ragdoll";

select * from Cats where breed like "R%" and
    fav_toy like "ball%" and
    coloration like "%m";

select * from Cats where age > 10 and
    (breed = "Ragdoll" or breed = "Abyssinian") and
    (fav_toy IS NOT NULL AND fav_toy <> "");
