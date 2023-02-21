SELECT order_date AS action_date,
    (SELECT name AS person_name FROM person WHERE person_order.person_id = person.id)
FROM person_order
INTERSECT
SELECT visit_date AS action_date,
    (SELECT name AS person_name FROM person WHERE person_visits.person_id = person.id)
FROM person_visits
ORDER BY action_date ASC, person_name DESC;
