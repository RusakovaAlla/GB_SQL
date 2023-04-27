drop database if exists practice4;
create database if not exists practice4;
use practice4;

CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
-- Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
select `name`, shopname
from shops
left join cats
	on shops.id = cats.shops_id
where `name` is not null;

-- Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
select shopname
from shops
left join cats
	on shops.id = cats.shops_id
where `name`='Murzik';
-- или
select shopname
from shops
where id in (Select shops_id from cats where `name`='Murzik');

-- Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

select shopname
from shops
where id not in (select shops_id from cats where `name` in ('Murzik', 'Zuza'));

