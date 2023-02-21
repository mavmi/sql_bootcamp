set enable_seqscan = off;

explain analyse
select
    menu.pizza_name as pizza_name,
    pizzeria.name as pizzeria_name
from menu
    left join pizzeria on menu.pizzeria_id = pizzeria.id;
