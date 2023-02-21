select
    person.address as address,
    pizzeria.name as name,
    count(person_order.person_id) as count_of_orders
from person_order
    join person on person.id = person_order.person_id
    join menu on menu.id = person_order.menu_id
    join pizzeria on pizzeria.id = menu.pizzeria_id
group by person.address, pizzeria.name
order by address, name;
