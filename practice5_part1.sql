DROP DATABASE IF EXISTS practice5;
CREATE DATABASE IF NOT EXISTS practice5;

USE practice5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE VIEW cheap_cars AS
SELECT *
FROM cars
WHERE cost<25000;

SELECT * FROM cheap_cars; -- проверяем

ALTER VIEW cheap_cars AS
SELECT *
FROM cars
WHERE cost<30000;

SELECT * FROM cheap_cars; -- проверяем

CREATE VIEW sk_au AS
SELECT *
FROM cars
WHERE `name` IN ('Audi', 'Skoda');

SELECT * FROM sk_au; -- проверяем