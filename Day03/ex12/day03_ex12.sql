INSERT INTO person_order
SELECT generate_series(
    (SELECT MAX(id) + 1 FROM person_order),
    (SELECT MAX(person_order.id) + MAX(person.id) 
        FROM person_order LEFT JOIN person ON person_order.person_id = person.id),
    1
),
generate_series((SELECT MIN(id) FROM person), (SELECT MAX(id) FROM person), 1),
(SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
'2022-02-25';
