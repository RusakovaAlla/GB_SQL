USE practice4_part3;

-- Получите друзей пользователя с id=1 (решение задачи с помощью представления “друзья”)

create view friends_user_1 as
SELECT initiator_user_id 
FROM friend_requests
WHERE target_user_id = 1 AND `status`='approved'
UNION 
SELECT target_user_id
FROM friend_requests
WHERE initiator_user_id = 1 AND `status`='approved';

select * from friends_user_1;

-- Создайте представление, в котором будут выводится все сообщения, в которых принимал участие пользователь с id = 1.
create view messages_part_user_1 as
SELECT from_user_id, to_user_id, body 
FROM messages
WHERE from_user_id = 1
UNION 
SELECT from_user_id, to_user_id, body 
FROM messages
WHERE to_user_id = 1;

select * from messages_part_user_1;

-- Получите список медиафайлов пользователя с количеством лайков(media m, likes l ,users u)

select filename, COUNT(filename) as num_likes
from media as m
left join (select * from likes where user_id <> 1) as l -- исключаем лайки самому себе, если такие есть
on l.media_id=m.id -- не поняла, зачем нужно здесь джойнить users
where m.user_id=1 
group by filename
order by num_likes desc;

-- Получите количество групп у пользователей
select user_id, count(community_id)
from users_communities
group by user_id;

-- Вывести 3 пользователей с наибольшим количеством лайков за медиафайлы
-- создадим view
CREATE VIEW likes4media AS
select m.filename, l.user_id, u.email
from media as m
left join likes as l on l.media_id=m.id
left join (select id, email from users) as u on u.id=l.user_id;

-- а теперь считаем лайки
select email, count(email) as num_likes
from likes4media
group by email
ORDER BY num_likes desc, email desc
limit 3;



