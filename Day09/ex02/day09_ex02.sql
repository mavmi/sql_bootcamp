-- trigger function --
create or replace function fnc_trg_person_delete_audit() returns trigger as $$
begin
    insert into person_audit values(
        now(), 'D', old.id, old.name, old.age, old.gender, old.address
    );
    return old;
end;
$$ language plpgsql;

-- trigger --
create trigger trg_person_delete_audit
after delete on person
for each row
execute procedure fnc_trg_person_delete_audit();

-- check --
DELETE FROM person WHERE id = 10;
select * from person;
select * from person_audit;
