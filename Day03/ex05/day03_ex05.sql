WITH Visited AS (
    SELECT DISTINCT
        pizzeria.name AS pizzeria_name
    FROM person_visits
        LEFT JOIN person ON person_visits.person_id = person.id
        LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    WHERE person.name = 'Andrey'
), DidntOrder AS (
    SELECT DISTINCT
        pizzeria.name AS pizzeria_name
    FROM person_order
        LEFT JOIN person ON person_order.person_id = person.id
        LEFT JOIN menu ON person_order.menu_id = menu.id
        LEFT JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    WHERE person.name = 'Andrey' AND 
        pizzeria.name NOT IN (SELECT pizza_name FROM pizzeria)
)

(SELECT * FROM Visited) EXCEPT (SELECT * FROM DidntOrder) ORDER BY pizzeria_name;
