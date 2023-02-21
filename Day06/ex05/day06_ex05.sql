comment on table person_discounts
is 'Discounts in specific pizzerias for each username. Primary key. Cannot be null.';

comment on column person_discounts.id
is 'Discount''s id: bigint, primary key. Cannot be null.';

comment on column person_discounts.person_id
is 'Person''s id. Reference to person.id column. Cannot be null.';

comment on column person_discounts.pizzeria_id
is 'Pizzeria''s id. Reference to pizzeria.id column. Cannot be null.';

comment on column person_discounts.discount
is 'Value of discount for specified username. Cannot be null. Must be in range from 0 and 100. 0 by default.';
