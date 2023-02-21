/*
 * Another solution with JOINs:
 *
	select (
		nd1.cost + nd2.cost + nd3.cost + nd4.cost
	) as total_cost,
	(
		'{' || nd1.node1 || ',' || nd1.node2 || ',' || nd3.node1
		|| ',' || nd3.node2 || ',' || nd4.node2 || '}'
	) as tour
	from nodes as nd1
		join nodes as nd2 on nd2.node1 = nd1.node2 and nd2.node2 != nd1.node1
		join nodes as nd3 on nd3.node1 = nd2.node2 and nd3.node2 != nd2.node1
			and nd3.node2 != nd1.node1
		join nodes as nd4 on nd4.node1 = nd3.node2 and nd4.node2 = nd1.node1
	where nd1.node1 = 'a'
	order by 1, 2;
 */

select * from f_salesman();
