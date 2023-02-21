WITH NewPizzeriaId AS (
    SELECT DISTINCT
        pizzeria.name AS pizzeria_name,
        pizzeria.id AS pizzeria_id
    FROM person_visits
        LEFT JOIN menu ON person_visits.pizzeria_id = menu.pizzeria_id
        LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    WHERE menu.price < 800 AND
        pizzeria.name NOT IN (SELECT name FROM mv_dmitriy_visits_and_eats)
    LIMIT 1
)

INSERT INTO person_visits VALUES(
    (SELECT MAX(id) + 1 FROM person_visits),
    (SELECT id FROM person WHERE name = 'Dmitriy'),
    (SELECT pizzeria_id FROM NewPizzeriaId),
    '2022/01/08'
);

-- SELECT * FROM mv_dmitriy_visits_and_eats;
REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
-- SELECT * FROM mv_dmitriy_visits_and_eats;
