SELECT
    Person1.name AS person_name1,
    Person2.name AS person_name2,
    Person1.address AS common_address
FROM person AS Person1
    LEFT JOIN person AS Person2 ON Person1.address = Person2.address
WHERE Person1.id > Person2.id
ORDER BY person_name1, person_name2, common_address;
