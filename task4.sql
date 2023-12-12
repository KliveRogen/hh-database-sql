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

