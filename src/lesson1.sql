CREATE TABLE product
(
    id       BIGINT,
    name     VARCHAR(100),
    price    DOUBLE PRECISION,
    category VARCHAR,
    date     DATE
);

CREATE TABLE customer
(
    id   BIGINT,
    name VARCHAR(100),
    type VARCHAR
);

CREATE TABLE "order"
(
    id          BIGINT,
    customer_id BIGINT,
    product_id  BIGINT,
    status      VARCHAR
);