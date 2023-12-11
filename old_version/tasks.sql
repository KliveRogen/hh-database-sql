/*
    Получение средних зачений по регионам (area_id) для следующих величин,
    compensation_from, compensation_to, среднее_арифметическое_from_и_to
*/
SELECT area.title                                            AS area,
       round(AVG(compensation_from))                         as avg_compensation_from,
       round(AVG(compensation_to))                           as avg_compensation_to,
       round(AVG((compensation_to - compensation_from) / 2)) as avg_compensation_to_from
FROM vacancy
         JOIN area on area.id = vacancy.area_id
GROUP BY area.title;

/*
    Запрос для получения месяцев с наибольшим количеством вакансий
*/

SELECT extract(month from created_at) AS most_vacancies_month, count(*) AS vacancy_count
FROM vacancy
GROUP BY most_vacancies_month
HAVING count(*) = (SELECT max(vacancy_count_inner)
                   FROM (SELECT count(*) AS vacancy_count_inner
                         FROM vacancy vc
                         GROUP BY extract(month from vc.created_at)) as inner_query);

/*
 Запрос для получения месяцев с наибольшим количеством резюме
 */

SELECT extract(month from created_at) AS most_resumes_month, count(*) AS resume_count
FROM resume
GROUP BY most_resumes_month
HAVING count(*) = (SELECT max(resume_count_inner)
                   FROM (SELECT count(*) AS resume_count_inner
                         FROM resume r
                         GROUP BY extract(month from r.created_at)) as inner_query);


/*
 Запрос для получения id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации
 */

SELECT f.vacancy_id, v.title, count(*) as feedback_count
FROM feedback f
         JOIN vacancy v ON v.id = f.vacancy_id
WHERE extract(DAY FROM f.created_at - v.created_at) <= 7
GROUP BY f.vacancy_id, v.title
HAVING count(*) > 5;


