DROP DATABASE IF EXISTS practice5_part2;
CREATE DATABASE IF NOT EXISTS practice5_part2;

USE practice5_part2;
drop table train_schedule;
CREATE TABLE IF NOT EXISTS train_schedule
(
-- id INT PRIMARY KEY AUTO_INCREMENT,
id_train VARCHAR(45),
route_station VARCHAR(45) not null,
time_arrival VARCHAR(45)
);

-- LOAD DATA не сработала, как ни билась. Ошибки вылетали разные, загрузила данные через Table Data Import Wizard
-- LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\fake_schedule1.csv' 
-- INTO TABLE train_schedule 
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY 'n';
-- IGNORE 1 ROWS;

ALTER TABLE train_schedule
MODIFY COLUMN id_train INT,
MODIFY COLUMN time_arrival TIME;

SELECT * FROM train_schedule;

SELECT
	id_train,
	route_station,
    time_arrival,
    timediff(lead(time_arrival) OVER(PARTITION BY id_train), time_arrival) as time_travel    
FROM train_schedule;



