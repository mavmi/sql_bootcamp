select
    name,
    (
        case
            when (po.count is not null and pv.count is not null) then (po.count + pv.count)
            when (po.count is not null and pv.count is null) then (po.count)
            when (po.count is null and pv.count is not null) then (pv.count)
            else 0
        end
    ) as total_count
from
    (
        select
            pizzeria.name as name,
            count(pizzeria.id) as count,
            'visit' as action_type
        from person_visits
            join pizzeria on person_visits.pizzeria_id = pizzeria.id
        group by name
    ) as po
    full join
    (
        select
            pizzeria.name as name,
            count(pizzeria.id) as count,
            'order' as action_type
        from person_order
            join menu on person_order.menu_id = menu.id
            join pizzeria on menu.pizzeria_id = pizzeria.id
        group by name
    ) as pv
using(name)
order by total_count desc, name asc;
