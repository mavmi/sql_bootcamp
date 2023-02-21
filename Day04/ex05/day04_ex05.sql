CREATE VIEW v_price_with_discount AS
SELECT
    person.name AS name,
    menu.pizza_name AS pizza_name,
    menu.price AS price,
    ROUND(menu.price - menu.price * 0.1) AS discount_price
FROM person_order
    LEFT JOIN person ON person_order.person_id = person.id
    LEFT JOIN menu ON person_order.menu_id = menu.id
ORDER BY name, pizza_name;

SELECT * FROM v_price_with_discount;
