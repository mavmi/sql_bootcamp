select
    person.name as name,
    count(*) as count_of_visits
from person_visits
    join person on person.id = person_visits.person_id
group by name
order by count_of_visits desc, name asc
limit 4;
