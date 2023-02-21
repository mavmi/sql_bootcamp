-- init table --
create table person_audit(
    created timestamptz not null default current_timestamp,
    type_event char(1) not null default 'I',
    row_id bigint not null,
    name varchar,
    age integer,
    gender varchar,
    address varchar,
    constraint ch_type_event check (type_event in ('I', 'U', 'D'))
);

-- create trigger function --
create or replace function fnc_trg_person_insert_audit() returns trigger as $$
begin
    insert into person_audit values(
        now(), 'I', new.id, new.name, new.age, new.gender, new.address
    );
    return new;
end;
$$ language plpgsql;

-- create trigger --
create trigger trg_person_insert_audit
after insert on person
for each row
execute procedure fnc_trg_person_insert_audit();

-- make insert --
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

-- check --
select * from person;
select * from person_audit;
