create or replace function fnc_fibonacci(pstop integer default 10)
    returns table(fibonacci integer) as $$

    with recursive fnc as (
        select
            0 as lhs,
            1 as rhs,
            0 as res
        union
        select
            rhs as lhs,
            res as rhs,
            (rhs + res) as res
        from fnc
        where rhs + res < pstop
    )
    select res from fnc;

$$ language sql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
