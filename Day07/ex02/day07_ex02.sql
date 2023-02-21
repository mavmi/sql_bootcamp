(
    select
        pizzeria.name as name,
        count(pizzeria.id) as count,
        'visit' as action_type
    from person_visits
        join pizzeria on person_visits.pizzeria_id = pizzeria.id
    group by name
    order by count desc
    limit 3
)
union all
(
    select
        pizzeria.name as name,
        count(pizzeria.id) as count,
        'order' as action_type
    from person_order
        join menu on person_order.menu_id = menu.id
        join pizzeria on menu.pizzeria_id = pizzeria.id
    group by name
    order by count desc
    limit 3
)
order by action_type asc, count desc;
