with actual_currency as (
	select 
		id,
  		name,
  		max(rate_to_usd) as rate_to_usd,
  		max(updated) as updated
  	from currency
  	group by(id, name)
), whole_info as (
    select
        coalesce(u.name, 'not defined') as name,
  		coalesce(u.lastname, 'not defined') as lastname,
  		b.type as type,
  		trim_scale(sum(b.money)) as volume,
  		coalesce(c.name, 'not defined') as currency_name,
    	coalesce(c.rate_to_usd, 1) as last_rate_to_usd
    from balance as b
        full join "user" as u on b.user_id = u.id
        full join actual_currency as c on b.currency_id = c.id
  	group by(u.name, u.lastname, b.type, c.name, c.rate_to_usd)
)

select
    name,
    lastname,
    type,
    volume,
    currency_name,
    last_rate_to_usd,
    trim_scale(volume * last_rate_to_usd) as total_volume_in_usd
from whole_info
order by name desc, lastname asc, type asc;
