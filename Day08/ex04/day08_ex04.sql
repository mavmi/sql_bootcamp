-- Session #1 --
SHOW TRANSACTION ISOLATION LEVEL;

-- Session #2 --
SHOW TRANSACTION ISOLATION LEVEL;

-- Session #1 --
begin transaction isolation level serializable;

-- Session #2 --
begin transaction isolation level serializable;

-- Session #1 --
select rating from pizzeria where name = 'Pizza Hut';

-- Session #2 --
update pizzeria set rating = 3.0 where name = 'Pizza Hut';
commit;

-- Session #1 --
select rating from pizzeria where name = 'Pizza Hut';
commit;
select rating from pizzeria where name = 'Pizza Hut';

-- Session #2 --
select rating from pizzeria where name = 'Pizza Hut';
