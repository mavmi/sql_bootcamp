-- Session #1 --
SHOW TRANSACTION ISOLATION LEVEL;

-- Session #2 --
SHOW TRANSACTION ISOLATION LEVEL;

-- Session #1 --
begin;

-- Session #2 --
begin;

-- Session #1 --
select rating from pizzeria where name = 'Pizza Hut';

-- Session #2 --
update pizzeria set rating = 3.6 where name = 'Pizza Hut';
commit;

-- Session #1 --
select rating from pizzeria where name = 'Pizza Hut';
commit;
select rating from pizzeria where name = 'Pizza Hut';

-- Session #2 --
select rating from pizzeria where name = 'Pizza Hut';
