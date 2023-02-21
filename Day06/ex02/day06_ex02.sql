select
    person.name as name,
    menu.pizza_name as pizza_name,
    menu.price as price,
    trim_scale(menu.price - (menu.price / 100 * person_discounts.discount)) as discount_price,
    pizzeria.name as pizzeria_name
from person_order
    join person_discounts on person_order.person_id = person_discounts.person_id
    join person on person_order.person_id = person.id
    join menu on person_order.menu_id = menu.id
    join pizzeria on menu.pizzeria_id = pizzeria.id
order by name, pizza_name;
