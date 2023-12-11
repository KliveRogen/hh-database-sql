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


create table feedback
(
    id         serial primary key,
    resume_id  integer   not null references resume (id),
    vacancy_id integer   not null references vacancy (id),
    status_id  integer   not null references feedback_status (id),
    created_at timestamp not null
);


