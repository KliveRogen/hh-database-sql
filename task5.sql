/*
 Запрос для получения id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации
 */

SELECT f.vacancy_id, v.title, count(*) as feedback_count
FROM feedback f
         JOIN vacancy v ON v.id = f.vacancy_id
WHERE extract(DAY FROM f.created_at - v.created_at) <= 7
GROUP BY f.vacancy_id, v.title
HAVING count(*) > 5;
