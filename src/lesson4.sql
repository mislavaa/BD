ALTER TABLE book
    ADD COLUMN price DECIMAL(10, 2);

UPDATE book
SET price = 550
WHERE id = 1;

UPDATE book
SET price = 850
WHERE id = 2;

UPDATE book
SET price = 1550.7898
WHERE id = 3;

-- Средняя цена, минимальная и максимальная
SELECT AVG(price) AS avg_price,
       MIN(price) AS min_price,
       MAX(price) AS max_price
FROM book;

-- Запрос, подсчитывающий количество книг, относящихся к каждому автору
SELECT a.name, a.surname, COUNT(ba.book_id) AS book_count
FROM author a
         JOIN book_author ba ON a.id = ba.author_id
GROUP BY a.name, a.surname
ORDER BY a.name;

-- Запрос, подсчитывающий количество книг и среднюю цену этих книг, относящихся к каждому автору
SELECT a.name,
       a.surname,
       COUNT(ba.book_id) AS book_count,
       AVG(price)        AS avg_price
FROM author a
         JOIN book_author ba ON a.id = ba.author_id
         JOIN book b ON b.id = ba.book_id
GROUP BY a.name, a.surname
ORDER BY a.name;

-- Авторы без книг
INSERT INTO author (surname, name)
VALUES ('Пушкин', 'Александр'),
       ('Гоголь', 'Николай'),
       ('Лермонтов', 'Михаил');

INSERT INTO book_author (author_id)
VALUES (4),
       (5),
       (6);

SELECT a.surname, ba.book_id
FROM author a
         LEFT JOIN book_author ba ON a.id = ba.author_id
WHERE ba.book_id IS NULL
ORDER BY a.surname;

SELECT a.name, a.surname
FROM author a
         JOIN book_author ba ON a.id = ba.author_id
GROUP BY a.name, a.surname
HAVING COUNT(ba.book_id) = 0
ORDER BY a.name;