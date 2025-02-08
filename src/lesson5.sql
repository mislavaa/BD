-- создание иерархии
-- гендир
  -- руководитель производства
     -- электрик
     -- слесарь
  -- фин. руководитель
     -- бухгалтер 1
     -- бухгалтер 2

CREATE TABLE category
(
    id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name      VARCHAR(50) NOT NULL,
    parent_id INT,

    CONSTRAINT fk_category FOREIGN KEY (parent_id) REFERENCES category (id) ON DELETE SET NULL
);

INSERT INTO category (name, parent_id)
VALUES ('Генеральный директор', null),
       ('Руководитель производства', 1),
       ('Электрик', 2),
       ('Слесарь', 2),
       ('Фин. руководитель', 1),
       ('Бухгалтер 1', 5),
       ('Бухгалтер 2', 5);

SELECT *
FROM category;