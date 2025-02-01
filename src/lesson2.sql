-- ПРОДУКТЫ

CREATE TABLE product (
    id       BIGINT GENERATED ALWAYS AS IDENTITY,
    name     VARCHAR(100),
    category VARCHAR(100),
    date     DATE
);

-- ПОКУПАТЕЛИ

CREATE TABLE customer (
    id   BIGINT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    type VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO customer (name, type, city)
VALUES ('Иван', 'REGULAR', 'Иркутск'),
       ('Анна', 'NEW', 'Ленинград'),
       ('Степан', 'VIP', 'Ленинград');

UPDATE customer
SET name = 'Елена'
WHERE id = 2;

UPDATE customer
SET city = 'Санкт-Петербург'
WHERE city = 'Ленинград';

DELETE
FROM customer
WHERE id = 1;

SELECT *
FROM customer;

SELECT id,
       name AS "Имя покупателя",
       type AS "Тип покупателя",
       city AS "Город"
FROM customer
WHERE city = 'Санкт-Петербург'
ORDER BY name;

-- ЗАКАЗЫ

CREATE TABLE "order" (
    id          BIGINT GENERATED ALWAYS AS IDENTITY,
    customer_id BIGINT,
    product_id  BIGINT,
    status      VARCHAR(100)
);