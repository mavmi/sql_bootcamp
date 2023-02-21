SELECT object_name FROM
    (SELECT pizza_name AS object_name, '2' AS type FROM menu
        UNION ALL
    SELECT name AS object_name, '1' AS type FROM person
    ORDER BY object_name) AS output
ORDER BY type, object_name;
