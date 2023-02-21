SELECT generated_date::date AS missing_date FROM v_generated_dates
WHERE generated_date NOT IN 
    (SELECT visit_date FROM person_visits WHERE DATE_PART('month', generated_date) = 1)
ORDER BY missing_date;
