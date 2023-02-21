SELECT
    menu.pizza_name AS pizza_name,
    pizzeria.name AS pizzeria_name
FROM person
LEFT JOIN person_order ON person.id = person_order.person_id
LEFT JOIN menu ON person_order.menu_id = menu.id
LEFT JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE (person.name = 'Denis' OR person.name = 'Anna')
ORDER BY pizza_name, pizzeria_name;
