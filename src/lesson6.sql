-- Добавление столбца "количество страниц"
ALTER TABLE book
    ADD COLUMN page_count INT CHECK (page_count >= 0);

UPDATE book
SET page_count = 245
WHERE id = 1;

UPDATE book
SET page_count = 530
WHERE id = 2;

UPDATE book
SET page_count = 313
WHERE id = 3;

INSERT INTO book(name, date, publisher_id, price, page_count, amount)
VALUES ('Книга 8', '2023-10-26', 1, 2000, 530, 600);

-- Книги, количество страниц в которых больше среднего
SELECT name, page_count
FROM book
WHERE page_count > (SELECT AVG(page_count) FROM book)
ORDER BY page_count;

-- Добавление столбца "количество экземпляров"
ALTER TABLE book
    ADD COLUMN amount INT DEFAULT (0) CHECK (amount >= 0);

UPDATE book
SET amount = 200
WHERE id = 1;

UPDATE book
SET amount = 1000
WHERE id = 2;

UPDATE book
SET amount = 500
WHERE id = 3;

-- Самые свежие книги
SELECT *
FROM book
WHERE date = (SELECT MAX(date) FROM book);

-- 3 реализации
-- Having
SELECT name, SUM(amount * price) AS total
FROM book
GROUP BY name
HAVING SUM(amount * price) > 500000
ORDER BY total;

-- Подзапрос
SELECT *
FROM (SELECT name, SUM(amount * price) AS total
      FROM book
      GROUP BY name)
WHERE total > 500000
ORDER BY total;

-- CTE
WITH book_total_sum AS (SELECT name, SUM(amount * price) AS total
                        FROM book
                        GROUP BY name)

SELECT *
FROM book_total_sum
WHERE total > 500000
ORDER BY total;

-- Насколько книга новая
SELECT b.id, b.name, b.date,
       a.surname || ' ' || a.name AS fio_author,
       CASE
           WHEN b.date < '2015-12-31' THEN 'Книга старого образца'
           WHEN b.date BETWEEN '2015-12-31' AND '2020-12-31' THEN 'Книга нового образца'
           ELSE 'Новинки'
           END                    AS book_status
FROM book b
         JOIN book_author ba ON ba.book_id = b.id
         JOIN author a ON ba.author_id = a.id;