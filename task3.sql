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
