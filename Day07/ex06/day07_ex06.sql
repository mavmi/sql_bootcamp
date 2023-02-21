select
    pizzeria.name as name,
    count(pizzeria_id) as count_of_orders,
    trim_scale(round(avg(menu.price), 2)) as average_price,
    max(menu.price) as max_price,
    min(menu.price) as min_price
from person_order
    join menu on menu.id = person_order.menu_id
    join pizzeria on menu.pizzeria_id = pizzeria.id
group by name
order by name;
