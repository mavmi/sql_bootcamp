WITH PersonCte AS(
    SELECT
        person.name AS Name,
        menu.pizza_name AS PizzaName
    FROM person_order
        LEFT JOIN person ON person_order.person_id = person.id
        LEFT JOIN menu ON person_order.menu_id = menu.id
    WHERE
        person.gender = 'female'
)

SELECT 
    PersonCte.Name AS name
FROM PersonCte
WHERE PersonCte.PizzaName = 'pepperoni pizza'
INTERSECT
SELECT 
    PersonCte.name AS name
FROM PersonCte
WHERE PersonCte.PizzaName = 'cheese pizza'
ORDER BY name;
