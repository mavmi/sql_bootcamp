create unique index idx_person_order_order_date
    on person_order using btree(person_id, menu_id)
where order_date = '2022-01-01';

set enable_seqscan = off;
explain analyse
select person_id from person_order
where menu_id = 1 and order_date = '2022-01-01';

-- explain analyse
-- select * from person_order;
