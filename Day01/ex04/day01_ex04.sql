SELECT (po_id.person_id - pv_id.person_id) as difference FROM
    (SELECT person_id FROM person_order WHERE order_date = '2022/01/07') AS po_id,
    (SELECT person_id FROM person_visits WHERE visit_date = '2022/01/07') AS pv_id;
