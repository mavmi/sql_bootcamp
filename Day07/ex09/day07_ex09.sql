select
    address,
    formula,
    average,
    (
        case
            when (formula > average) then true
            else false
        end
    ) as comparison
from
    (
        select
            address,
            trim_scale(round(max(age)::numeric - min(age)::numeric / max(age)::numeric, 2)) as formula,
            trim_scale(round(avg(age), 2)) as average
        from person
        group by address
    ) as tmp
order by address;
