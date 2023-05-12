use gb_homework;
-- Основное:
-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS split_time;
DELIMITER $$
CREATE FUNCTION split_time
(
	inp_num INT -- вводимое количество секунд     
)
RETURNS VARCHAR(90)
DETERMINISTIC
BEGIN
	DECLARE days_num INT;
	DECLARE hours_num INT;
	DECLARE minutes_num INT;
	DECLARE num INT;
	DECLARE time_text VARCHAR(90) DEFAULT "";
	SET num = inp_num;
	SET days_num = num div (24*60*60);
	SET num = num - days_num * 24 * 60 * 60;
	SET hours_num = num div (60*60);
	SET num = num - hours_num * 60 * 60;
	SET minutes_num = num div 60;
	SET num =  num - minutes_num * 60;
	SET time_text = CONCAT(days_num, " days ", hours_num, " hours ", minutes_num, " minutes ", num, " seconds");
RETURN time_text;
END $$
DELIMITER ;
-- Вызов функции
SELECT split_time(987654321) as 'Время';