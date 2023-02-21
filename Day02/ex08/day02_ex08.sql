SELECT
    person.name AS name
FROM person_order
    LEFT JOIN person ON person_order.person_id = person.id
    LEFT JOIN menu ON person_order.menu_id = menu.id
WHERE
    person.gender = 'male' AND
    (person.address = 'Moscow' OR person.address = 'Samara') AND
    (menu.pizza_name = 'pepperoni pizza' OR menu.pizza_name = 'mushroom pizza')
ORDER BY name DESC;
