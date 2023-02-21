/*
 * Vertion with UNION ALL:
 * _________________________________________________________________________________________________
	create or replace function fnc_find_nearest_date(currency_id integer, balance_updated timestamp)
		returns numeric as
	$$
		with cte_a as (
			(
				select rate_to_usd
				from currency
				where id = currency_id and updated < balance_updated
				order by updated desc
				limit 1
			)
			union all
			(
				select rate_to_usd
				from currency
				where id = currency_id and updated >= balance_updated
				order by updated asc
				limit 1
			)
		)
		select *
		from cte_a
		limit 1
	$$ language sql;


	select coalesce(u.name, 'not defined') as name,
		coalesce(u.lastname, 'not defined') as lastname,
		c.name as currency_name,
		(fnc_find_nearest_date(b.currency_id, b.updated) * b.money)::real as currency_in_usd
	from balance as b
		left join "user" as u on u.id = b.user_id
		join (select distinct id, name from currency) as c on b.currency_id = c.id
	order by 1 desc, 2 asc, 3 asc;
 */


-- INSERING STATEMENTS FROM SUBJECT
insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');
--


/* 
 * Finds the nearest currency (to current balance updated)
 * updated in past and returns it's rate_to_usd or NULL if
 * there are not updated in pass
 */
create or replace function fnc_find_nearest_past_rate(current_currency_id bigint, balance_updated timestamp)
	returns numeric as
$$
begin
	return (
		select rate_to_usd
		from currency
		where id = current_currency_id and updated < balance_updated
		order by (balance_updated - updated)
		limit 1
	);
end;
$$ language plpgsql;


/* 
 * Finds the nearest currency (to current balance updated)
 * updated in future and returns it's rate_to_usd
 */
create or replace function fnc_find_nearest_future_rate(current_currency_id bigint, balance_updated timestamp)
	returns numeric as
$$
begin
	return (
		select rate_to_usd
		from currency
		where id = current_currency_id and updated >= balance_updated
		order by (updated - balance_updated)
		limit 1
	);
end;
$$ language plpgsql;


/* 
 * Returns rate_to_usd of currency.id which sames as 
 * the passing current_currency_id with the rules below:
 * 	1.	Finds the nearest date in past and returns it's rate_to_usd
 * 	2.	If there aren't updates in past (returns NULL on first step)
 * 		then finds the nearest updateded in future and returns it's 
 * 		rate_to_usd
 */
create or replace function fnc_find_nearest_rate(current_currency_id bigint, balance_updated timestamp)
	returns numeric as
$$
declare
	pass_rate numeric := fnc_find_nearest_past_rate(current_currency_id, balance_updated);
begin
	if (pass_rate is not null) then return pass_rate; end if;
	return fnc_find_nearest_future_rate(current_currency_id, balance_updated);
end;
$$ language plpgsql;


select coalesce(u.name, 'not defined') as name,
	coalesce(u.lastname, 'not defined') as lastname,
	c_id.name as currency_name,
	(fnc_find_nearest_rate(b.currency_id, b.updated) * b.money)::real as currency_in_usd
from balance b
	join (select distinct id as currency_id, name from currency) as c_id using(currency_id)
	left join "user" as u on u.id = b.user_id
order by 1 desc, 2 asc, 3 asc;

