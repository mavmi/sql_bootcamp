-- trigger function --
create or replace function fnc_trg_person_update_audit() returns trigger as $$
begin
    insert into person_audit values(
        now(), 'U', old.id, old.name, old.age, old.gender, old.address
    );
    return old;
end;
$$ language plpgsql;

-- trigger --
create trigger trg_person_update_audit
after update on person
for each row
execute procedure fnc_trg_person_update_audit();

-- check --
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
select * from person;
select * from person_audit;
