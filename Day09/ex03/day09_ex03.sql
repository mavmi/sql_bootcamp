-- trigger function --
create or replace function fnc_trg_person_audit() returns trigger as $$
begin
    if TG_OP = 'INSERT' then
        insert into person_audit values(
            now(), 'I', new.id, new.name, new.age, new.gender, new.address
        ); 
    elsif TG_OP = 'UPDATE' then
        insert into person_audit values(
            now(), 'U', old.id, old.name, old.age, old.gender, old.address
        );
    elsif TG_OP = 'DELETE' or TG_OP = 'TRUNCATE' then
        insert into person_audit values(
            now(), 'D', old.id, old.name, old.age, old.gender, old.address
        );
    end if;
    return old;
end;
$$ language plpgsql;

-- trigger --
create trigger trg_person_audit
after insert or update or delete on person
for each row
execute procedure fnc_trg_person_audit();

-- drop --
drop trigger if exists trg_person_insert_audit on person;
drop trigger if exists trg_person_update_audit on person;
drop trigger if exists trg_person_delete_audit on person;

drop function if exists fnc_trg_person_insert_audit;
drop function if exists fnc_trg_person_update_audit;
drop function if exists fnc_trg_person_delete_audit;

delete from person_audit where true;

-- check --
INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
