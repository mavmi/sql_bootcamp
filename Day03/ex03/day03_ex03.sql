WITH FemaleVisits AS (
    SELECT 
        pizzeria.name AS pizzeria_name
    FROM person_visits
        LEFT JOIN person ON person_visits.person_id = person.id
        LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    WHERE person.gender = 'female'
), MaleVisits AS (
    SELECT 
        pizzeria.name AS pizzeria_name
    FROM person_visits
        LEFT JOIN person ON person_visits.person_id = person.id
        LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    WHERE person.gender = 'male'
)

(SELECT * FROM FemaleVisits EXCEPT ALL SELECT * FROM MaleVisits)
UNION ALL
(SELECT * FROM MaleVisits EXCEPT ALL SELECT * FROM FemaleVisits)
ORDER BY pizzeria_name;
