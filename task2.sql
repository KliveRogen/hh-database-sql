insert into area(title)
values ('Адыгея'),
       ('Алтай'),
       ('Алтайский край'),
       ('Амурская область'),
       ('Архангельская область'),
       ('Астраханская область'),
       ('Башкортостан'),
       ('Белгородская область'),
       ('Брянская область'),
       ('Бурятия'),
       ('Владимирская область'),
       ('Волгоградская область'),
       ('Вологодская область'),
       ('Воронежская область'),
       ('Дагестан'),
       ('Еврейская АО'),
       ('Забайкальский край'),
       ('Ивановская область'),
       ('Ингушетия'),
       ('Иркутская область'),
       ('Кабардино-Балкария'),
       ('Калининградская область'),
       ('Калмыкия'),
       ('Калужская область'),
       ('Камчатский край'),
       ('Карачаево-Черкессия'),
       ('Карелия'),
       ('Кемеровская область'),
       ('Кировская область'),
       ('Коми'),
       ('Костромская область'),
       ('Краснодарский край'),
       ('Красноярский край'),
       ('Курганская область'),
       ('Курская область'),
       ('Ленинградская область'),
       ('Липецкая область'),
       ('Магаданская область'),
       ('Марий Эл'),
       ('Мордовия'),
       ('Москва'),
       ('Московская область'),
       ('Мурманская область'),
       ('Ненецкий АО'),
       ('Нижегородская область'),
       ('Новгородская область'),
       ('Новосибирская область'),
       ('Омская область'),
       ('Оренбургская область'),
       ('Орловская область'),
       ('Пензенская область'),
       ('Пермский край'),
       ('Приморский край'),
       ('Псковская область'),
       ('Ростовская область'),
       ('Рязанская область'),
       ('Самарская область'),
       ('Санкт-Петербург'),
       ('Саратовская область'),
       ('Саха (Якутия)'),
       ('Сахалинская область'),
       ('Свердловская область'),
       ('Северная Осетия - Алания'),
       ('Смоленская область'),
       ('Ставропольский край'),
       ('Тамбовская область'),
       ('Татарстан'),
       ('Тверская область'),
       ('Томская область'),
       ('Тульская область'),
       ('Тыва'),
       ('Тюменская область'),
       ('Удмуртия'),
       ('Ульяновская область'),
       ('Хабаровский край'),
       ('Хакасия'),
       ('Ханты-Мансийский АО - Югра'),
       ('Челябинская область'),
       ('Чеченская республика'),
       ('Чувашская республика'),
       ('Чукотский АО'),
       ('Ямало-Ненецкий АО'),
       ('Ярославская область'),
       ('Крым'),
       ('Севастополь');


insert into feedback_status(title)
values ('Резюме не просмотрено'),
       ('Отказ'),
       ('Приглашение'),
       ('Резюме просмотрено');

with employer_data(id, title, description) as (SELECT generate_series(1, 3000) AS id,
                                                      md5(random()::text)      AS name,
                                                      md5(random()::text)      as description)

insert
into employer(id, title, description)
select employer_data.id, employer_data.title, employer_data.description
from employer_data;


insert into specialization (title)
values ('Разработичик backend'),
       ('Разработичик frontend'),
       ('Токарь'),
       ('Повар'),
       ('Разнорабочий'),
       ('Продавец-кассир'),
       ('DevOps инженер'),
       ('Аналитик'),
       ('Преподаватель'),
       ('Хореограф');



with vacancy_data(id, employer_id, specialization_id, title, description, area_id, salary,
                  created_at) as
         (SELECT generate_series(1, 10000)                                                                                      AS id,
                 floor(random() * 3000 + 1)::int                                                                                AS employer_id,
                 floor(random() * 10 + 1)::int                                                                                  AS specialization_id,
                 md5(random()::text)                                                                                            AS title,
                 md5(random()::text)                                                                                            as description,
                 floor(random() * 85 + 1)::int                                                                                  AS area_id,
                 floor(random() * 300000 + 15000)                                                                               AS salary,
                 date_trunc('second', '2019-01-01'::timestamp + random() *
                                                                ('2022-12-31'::timestamp - '2019-01-01'::timestamp))::timestamp as created_at)

insert
into vacancy(id, employer_id, specialization_id, title, description, area_id, compensation_from, compensation_to,
             created_at)
select vacancy_data.id,
       vacancy_data.employer_id,
       vacancy_data.specialization_id,
       vacancy_data.title,
       vacancy_data.description,
       vacancy_data.area_id,
       vacancy_data.salary,
       vacancy_data.salary + 30000,
       vacancy_data.created_at
from vacancy_data;


with resume_data(id, first_name, last_name, middle_name, is_male, area_id, phone_number, email, description,
                 specialization_id, created_at) as
         (SELECT generate_series(1, 100000)                                                                                     AS id,
                 md5(random()::text)                                                                                            as first_name,
                 md5(random()::text)                                                                                            as last_name,
                 md5(random()::text)                                                                                            as middle_name,
                 (round(random())::int)::boolean                                                                                as is_male,
                 floor(random() * 85 + 1)::int                                                                                  AS area_id,
                 substr(concat(md5(random()::text), md5(random()::text)), 0,
                        15)                                                                                                     as phone_number,
                 md5(random()::text)                                                                                            AS email,
                 md5(random()::text)                                                                                            as description,
                 floor(random() * 10 + 1)::int                                                                                  AS specialization_id,
                 date_trunc('second', '2019-01-01'::timestamp + random() *
                                                                ('2022-12-31'::timestamp - '2019-01-01'::timestamp))::timestamp as created_at)

insert
into resume(id, first_name, last_name, middle_name, is_male, area_id, phone_number, email, description,
            specialization_id, created_at)
select resume_data.id,
       resume_data.first_name,
       resume_data.last_name,
       resume_data.middle_name,
       resume_data.is_male,
       resume_data.area_id,
       resume_data.phone_number,
       resume_data.email,
       resume_data.description,
       resume_data.specialization_id,
       resume_data.created_at
from resume_data;


with feedback_data(id, resume_id, vacancy_id, status_id, created_at) as
         (SELECT generate_series(1, 20000)                                                                                      AS id,
                 floor(random() * 100000 + 1)::int                                                                              AS resume_id,
                 floor(random() * 10000 + 1)::int                                                                               AS vacancy_id,
                 floor(random() * 4 + 1)::int                                                                                   AS status_id,
                 date_trunc('second', '2019-01-01'::timestamp + random() *
                                                                ('2022-12-31'::timestamp - '2019-01-01'::timestamp))::timestamp as created_at)

insert
into feedback(id, resume_id, vacancy_id, status_id, created_at)
select feedback_data.id,
       feedback_data.resume_id,
       feedback_data.vacancy_id,
       feedback_data.status_id,
       date_trunc('second', (select(created_at) from vacancy WHERE id = feedback_data.vacancy_id) +  random() * ('2023-12-31'::timestamp - (select(created_at) from vacancy WHERE id = feedback_data.vacancy_id)))
from feedback_data;