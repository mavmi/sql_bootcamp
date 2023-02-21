create unique index idx_menu_unique on menu using btree(pizzeria_id, pizza_name);

set enable_seqscan = off;
explain analyse
select pizzeria_id, id from menu where pizza_name = 'cheese pizza';
