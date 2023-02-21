create index idx_person_name on person using btree(upper(name));

set enable_seqscan = off;
explain analyse
select id from person where upper(name) = 'ANNA';
