WITH FemaleOrders AS (
    SELECT 
        pizzeria.name AS pizzeria_name
    FROM person_order
        LEFT JOIN person ON person_order.person_id = person.id
        LEFT JOIN menu ON person_order.menu_id = menu.id
        LEFT JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    WHERE person.gender = 'female'
), MaleOrders AS (
    SELECT 
        pizzeria.name AS pizzeria_name
    FROM person_order
        LEFT JOIN person ON person_order.person_id = person.id
        LEFT JOIN menu ON person_order.menu_id = menu.id
        LEFT JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    WHERE person.gender = 'male'
)

(SELECT * FROM FemaleOrders EXCEPT SELECT * FROM MaleOrders)
UNION
(SELECT * FROM MaleOrders EXCEPT SELECT * FROM FemaleOrders)
ORDER BY pizzeria_name;
