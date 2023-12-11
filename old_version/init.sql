create table area
(
    id    serial primary key,
    title text not null unique
);

create table employer
(
    id          serial primary key,
    title       text not null unique,
    description text
);

create table specialization
(
    id    serial primary key,
    title text not null unique
);

create table feedback_status
(
    id    serial primary key,
    title text not null unique
);

create table resume
(
    id                serial primary key,
    first_name        text,
    last_name         text,
    middle_name       text,
    is_male           boolean   not null,
    area_id           integer references area (id),
    phone_number      varchar(15),
    email             text,
    description       text,
    specialization_id integer references specialization (id),
    created_at        timestamp not null
);

--Добавил индексы для email и phone_number, т.к. это более-менее уникальные поля, по которым можно довольно быстро найти резюме конкретного человека
create index resume_phone_number_index on resume (phone_number);
create index resume_email_index on resume (email);
--Добавил индексы по foreign key, чтобы быстрее производить поиск резюме по регионам, сециализации
create index fk_resume_area_id on resume (area_id);
create index fk_resume_specialization_id on resume (specialization_id);

create table vacancy
(
    id                serial primary key,
    employer_id       integer   not null references employer (id),
    specialization_id integer   not null references specialization (id),
    title             text      not null,
    description       text,
    area_id           integer references area (id),
    compensation_from integer,
    compensation_to   integer,
    created_at        timestamp not null
);
--Добавил индексы по foreign key, чтобы быстрее производить поиск вакансий по регионам, сециализации, работадателю
create index fk_vacancy_area_id on vacancy (area_id);
create index fk_vacancy_specialization_id on vacancy (specialization_id);
create index fk_vacancy_employer_id on vacancy (employer_id);


create table feedback
(
    id         serial primary key,
    resume_id  integer   not null references resume (id),
    vacancy_id integer   not null references vacancy (id),
    status_id  integer   not null references feedback_status (id),
    created_at timestamp not null
);
--Добавил индексы по foreign key, чтобы быстрее производить поиск откликов по резюме, вакансиям, статусу отклика
create index fk_feedback_resume_id on feedback (resume_id);
create index fk_feedback_vacancy_id on feedback (vacancy_id);
create index fk_feedback_status_id on feedback (status_id);

