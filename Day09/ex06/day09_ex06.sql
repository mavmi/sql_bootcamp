/*
create or replace function fnc_person_visits_and_eats_on_date(pperson varchar default 'Dmitriy', pprice numeric default 500, pdate date default '2022-01-08')
    returns table(name varchar) as $$
begin
    return query
        select
            pizzeria.name
        from person_order
            join person on person.id = person_order.person_id
            join menu on menu.id = person_order.menu_id
            join pizzeria on menu.pizzeria_id = pizzeria.id
        where 
            person.name = pperson and
            menu.price < pprice and
            person_order.order_date = pdate and
            pizzeria.name in (
                select distinct
                    pizzeria.name
                from person_visits
                    join person on person.id = person_visits.person_id
                    join pizzeria on pizzeria.id = person_visits.pizzeria_id
                where
                    person.name = pperson and
                    person_visits.visit_date = pdate
            );
end;
$$ language plpgsql;
*/

create or replace function fnc_person_visits_and_eats_on_date(pperson varchar default 'Dmitriy', pprice numeric default 500, pdate date default '2022-01-08')
    returns table(name varchar) as $$
begin
    return query
        select distinct
            pizzeria.name
        from person_order
            join person on person.id = person_order.person_id
            join menu on menu.id = person_order.menu_id
            join pizzeria on menu.pizzeria_id = pizzeria.id
        where 
            person.name = pperson and
            menu.price < pprice and
            person_order.order_date = pdate and
            pizzeria.name in (
                select distinct
                    pizzeria.name
                from person_visits
                    join person on person.id = person_visits.person_id
                    join pizzeria on pizzeria.id = person_visits.pizzeria_id
                where
                    person.name = pperson and
                    person_visits.visit_date = pdate
            );
end;
$$ language plpgsql;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
