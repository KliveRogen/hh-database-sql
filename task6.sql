--Добавил индексы для email и phone_number, т.к. это более-менее уникальные поля, по которым можно довольно быстро найти резюме конкретного человека
create index resume_phone_number_index on resume (phone_number);
create index resume_email_index on resume (email);


--Добавил индексы по foreign key, чтобы быстрее производить поиск резюме по регионам, сециализации
create index fk_resume_area_id on resume (area_id);
create index fk_resume_specialization_id on resume (specialization_id);


--Добавил индексы по foreign key, чтобы быстрее производить поиск вакансий по регионам, сециализации, работадателю
create index fk_vacancy_area_id on vacancy (area_id);
create index fk_vacancy_specialization_id on vacancy (specialization_id);
create index fk_vacancy_employer_id on vacancy (employer_id);


--Добавил индексы по foreign key, чтобы быстрее производить поиск откликов по резюме, вакансиям, статусу отклика
create index fk_feedback_resume_id on feedback (resume_id);
create index fk_feedback_vacancy_id on feedback (vacancy_id);
create index fk_feedback_status_id on feedback (status_id);
