/* 1. Создать процедуру, которая решает следующую задачу
Выбрать для одного пользователя 5 пользователей в случайной комбинации, которые удовлетворяют хотя бы одному критерию:
1) из одного города
2) состоят в одной группе
3) друзья друзей
*/

USE practice4_part3;

UPDATE profiles
SET hometown = 'Adriannaport'
WHERE birthday < '1990-01-01'; -- разобралась, зачем это нужно, оставила как есть

-- создание процедуры
DROP PROCEDURE IF EXISTS users_recommend4friends;
DELIMITER //
CREATE PROCEDURE users_recommend4friends(for_user_id BIGINT)
BEGIN
DECLARE ht VARCHAR(45);
SET ht = (SELECT hometown FROM profiles WHERE user_id=for_user_id); -- определяем город
SELECT * FROM users -- выбираем пользователей из одного города
WHERE id IN (
	SELECT user_id 
    FROM profiles
	WHERE 
		hometown=ht AND
		user_id <> for_user_id
UNION 
SELECT DISTINCT(user_id) -- список пользователей состоящих в одной группе с данным пользователем
FROM users_communities
WHERE 
	user_id <> for_user_id AND
	community_id IN (SELECT DISTINCT(community_id) FROM users_communities WHERE user_id=for_user_id)
UNION
SELECT initiator_user_id -- друзья друзей, инициировавшие дружбу
FROM friend_requests
WHERE 
 `status`='approved' AND initiator_user_id <> for_user_id AND target_user_id <> for_user_id AND
 (initiator_user_id IN (SELECT initiator_user_id as friends_of_given_user
						FROM friend_requests
						WHERE 
							target_user_id = for_user_id AND 
                            `status`='approved'
						UNION 
						SELECT target_user_id
						FROM friend_requests
						WHERE 
							initiator_user_id = for_user_id AND 
                            `status`='approved'
						)
                        OR
target_user_id IN (SELECT initiator_user_id as friends_of_given_user
				   FROM friend_requests
				   WHERE 
						target_user_id = for_user_id AND 
                        `status`='approved'
				   UNION 
				   SELECT target_user_id
				   FROM friend_requests
				   WHERE 
						initiator_user_id = for_user_id AND 
                        `status`='approved'
					)
)
UNION
SELECT target_user_id -- друзья друзей, получатели запросов на дружбу
FROM friend_requests
WHERE 
 `status`='approved' AND initiator_user_id <> for_user_id AND target_user_id <> for_user_id AND
 (initiator_user_id IN (SELECT initiator_user_id AS friends_of_given_user
						FROM friend_requests
						WHERE target_user_id = for_user_id AND `status`='approved'
						UNION 
						SELECT target_user_id
						FROM friend_requests
						WHERE initiator_user_id = for_user_id AND `status`='approved')
                        OR
target_user_id IN (SELECT initiator_user_id AS friends_of_given_user
						FROM friend_requests
						WHERE target_user_id = for_user_id AND `status`='approved'
						UNION 
						SELECT target_user_id
						FROM friend_requests
						WHERE initiator_user_id = for_user_id AND `status`='approved'))
)
ORDER BY RAND() 
LIMIT 5;
END//
DELIMITER ;

-- вызов процедуры
CALL users_recommend4friends(1); -- верно ли, что для пользователя 1 пул выбора это все пользователи?


-- 2. Создать функцию, вычисляющей коэффициент популярности пользователя

/* из задания и объяснения на семинаре не поняла, что именно нужно сделать, поэтому подсмотрела решение. 
Фактически коэффициент равен отношению количества отправленных юзеру заявок в друзья к количеству отправленных заявок им самим
 */
DROP FUNCTION IF EXISTS pop_coef;
DELIMITER //
CREATE FUNCTION pop_coef(
	check_user BIGINT
)
RETURNS FLOAT 
DETERMINISTIC
BEGIN
DECLARE request_inbound INT;
DECLARE request_outbound INT;
DECLARE coef float;
SET request_inbound = (SELECT COUNT(DISTINCT(initiator_user_id)) -- входящие заявки пользователю
						   FROM friend_requests 
                           WHERE target_user_id=check_user);
SET request_outbound = (SELECT COUNT(DISTINCT(target_user_id)) -- входящие заявки пользователю
						   FROM friend_requests 
                           WHERE initiator_user_id=check_user);                           
IF request_outbound<>0 THEN 
	SET coef = (request_inbound/request_outbound);
ELSE SET coef = 0;
END IF; 
RETURN round(coef*100, 2);
END//
DELIMITER ;
SELECT pop_coef(2);

