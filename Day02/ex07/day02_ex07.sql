SELECT pizzeria.name
FROM person_visits
    LEFT JOIN person ON person.id = person_visits.person_id
    LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    LEFT JOIN menu ON pizzeria.id = menu.pizzeria_id
WHERE 
    person.name = 'Dmitriy' AND
    person_visits.visit_date = '2022/01/08' AND
    menu.price < 800
