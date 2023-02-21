create index idx_menu_pizzeria_id on menu using btree(pizzeria_id);

create index idx_person_visits_person_id on person_visits using btree(person_id);
create index idx_person_visits_pizzeria_id on person_visits using btree(pizzeria_id);

create index idx_person_order_person_id on person_order using btree(person_id);
create index idx_person_order_menu_id on person_order using btree(menu_id);
