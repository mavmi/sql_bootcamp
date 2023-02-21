insert into person_discounts
select
    row_number() over() as id,
    person_order.person_id as person_id,
    menu.pizzeria_id as pizzeria_id,
    (
        case
            when count(*) = 1 then 10.5
            when count(*) = 2 then 22
            else 30
        end
    ) as discount
from person_order
    left join menu on person_order.menu_id = menu.id
group by person_id, pizzeria_id;
