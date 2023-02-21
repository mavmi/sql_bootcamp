/*
 * About DDL: https://habr.com/ru/post/255361/
 *
 *
 * In this file useded DDL' for table creation with INSERT's of data
 *
 * 	________________________________________________________________________________
 * 	'DDL – Data Definition Language (for creating/changing/dropping tables and links)
 * 
 * About recurtion:
 * https://habr.com/ru/post/269497/
 * 
 * About recursive view:
 * https://www.geeksforgeeks.org/postgresql-create-recursive-views/
 * 
 * Difference between DDL and DML:
 * https://www.geeksforgeeks.org/difference-between-ddl-and-dml-in-dbms/
 *
 * Work with strings:
 * https://postgrespro.ru/docs/postgrespro/9.6/functions-string
 *
 */
 
 -- Data table initialization --
drop table if exists nodes;
create table if not exists nodes (
	node1 bpchar not null,
	node2 bpchar not null,
	cost integer not null
);
insert into nodes values
	('a', 'b', 10),
	('a', 'd', 20),
	('a', 'c', 15),
	('b', 'a', 10),
	('b', 'c', 35),
	('b', 'd', 25),
	('c', 'a', 15),
	('c', 'b', 35),
	('c', 'd', 30),
	('d', 'a', 20),
	('d', 'b', 25),
	('d', 'c', 30);

 -- Creation of views with all possible ways --
create recursive view v_recursive_salesman(total_cost, node1, node2, tour) as (
	select
		cost as total_cost,
		node1 as node1,
		node2 as node2,
		array[node1] as tour
	from nodes
	where node1 = 'a'
	union
	select 
		v_recursive_salesman.total_cost + nd.cost as total_cost,
		nd.node1 as node1,
		nd.node2 as node2,
		(v_recursive_salesman.tour || nd.node1) as tour
	from nodes nd
		join v_recursive_salesman on v_recursive_salesman.node2 = nd.node1 and nd.node2 != v_recursive_salesman.node1
			and (not nd.node2 = any(tour) or (array_length(tour, 1) = 3 and nd.node2 = 'a'))
);

create or replace function f_salesman() returns table(total_cost int, tour text) language sql as $$
	select
		total_cost,
		format('{%s,%s,%s,%s,%s}', tour[1], tour[2], tour[3], tour[4], 'a') as tour
	from v_recursive_salesman
	where array_length(tour, 1) = 4
	order by total_cost, tour
$$;

 -- ex00 --
select * from f_salesman()
where total_cost = (select min(total_cost) from f_salesman())
