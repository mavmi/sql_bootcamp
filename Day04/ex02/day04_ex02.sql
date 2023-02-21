CREATE VIEW v_generated_dates AS
SELECT generate_series('2022-01-01'::date, '2022-01-31'::date, '1 day'::interval) as generated_date
ORDER BY generated_date;

SELECT generated_date::date FROM v_generated_dates;
