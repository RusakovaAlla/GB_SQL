USE gb_homework;

DROP TABLE IF EXISTS staff;

CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    firstname VARCHAR(45),
    lastname VARCHAR(45),
    post VARCHAR(45),
    seniority INT, 
    salary DECIMAL (8,2),
    age INT
);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
 
 -- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
 select salary
 from staff
 order by salary asc; -- desc
 
 -- Выведите 5 максимальных заработных плат (saraly)
 select salary
 from staff
 order by salary desc
 limit 5; 
 
 -- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
 select post, sum(salary) as sum_salary
 from staff
 group by post;
 
 -- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
 select count(post)
 from staff
 where 
	post = 'Рабочий' and
    age between 24 and 49;
    
-- Найдите количество специальностей
select count(distinct post) as posts
from staff;

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет включительно
select post, avg(age) as average_age
from staff
group by post
having average_age<=30; 
 