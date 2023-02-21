select
    person.name,
    visits_count.count_of_visits
from
(
    select
        person_id,
        count(person_id) as count_of_visits
    from person_visits
    group by person_id
) as visits_count
    join person on person.id = visits_count.person_id and visits_count.count_of_visits > 3;
