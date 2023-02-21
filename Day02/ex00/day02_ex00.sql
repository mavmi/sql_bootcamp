SELECT name, rating
    FROM pizzeria LEFT JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
WHERE visit_date IS NULL;
