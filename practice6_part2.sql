use gb_homework;
-- Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10
DROP FUNCTION IF EXISTS even_nums;
DELIMITER $$
CREATE FUNCTION even_nums
(
	start_num INT, -- начало числового ряда
    end_num INT -- конец числового ряда    
)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
	DECLARE n INT;
	DECLARE even_num_text VARCHAR(45) DEFAULT "";
    SET n = start_num;	
    REPEAT
     IF (n % 2 = 0) THEN
		SET even_num_text = CONCAT(even_num_text, n, " ");
	END IF;
	SET n = n + 1;
	UNTIL n > end_num    
	END REPEAT;	
	RETURN even_num_text;
END $$
DELIMITER ;
SELECT even_nums(1, 10) as 'xbckf';


