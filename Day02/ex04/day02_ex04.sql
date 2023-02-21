SELECT
    pizza_name AS pizza_name,
    (SELECT name FROM pizzeria WHERE pizzeria.id = pizzeria_id) AS pizzeria_name,
    price AS price
FROM menu
WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza'
ORDER BY pizza_name, pizzeria_name;
