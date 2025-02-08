-- ИЗДАТЕЛЬСТВА

CREATE TABLE publisher (
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name    VARCHAR(200) NOT NULL,
    address VARCHAR(200)
);

INSERT INTO publisher (name, address)
VALUES ('Эксмо', 'Санкт-Петербург'),
       ('АСТ', 'Москва');

SELECT *
FROM publisher;

-- КНИГИ

CREATE TABLE book (
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(200) NOT NULL,
    date         DATE,
    publisher_id BIGINT,

    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (id) ON DELETE SET NULL
);

ALTER TABLE book
    ADD CONSTRAINT date_check CHECK (date <= CURRENT_DATE);

INSERT INTO book (name, date, publisher_id)
VALUES ('Книга 1', '2015-01-25', 1),
       ('Книга 2', '2023-10-26', 1),
       ('Книга 3', '2020-03-07', 2);

ALTER TABLE book
    ADD COLUMN price DECIMAL(15,2) DEFAULT (-1) CHECK (price >= -1);

UPDATE book
SET price = 550
WHERE id = 1;

UPDATE book
SET price = 850
WHERE id = 2;

UPDATE book
SET price = 1550.7898
WHERE id = 3;

SELECT *
FROM book;

-- АВТОРЫ

CREATE TABLE author (
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    surname VARCHAR(100) NOT NULL,
    name    VARCHAR(100)
);

INSERT INTO author (surname, name)
VALUES ('Петров', 'Пётр'),
       ('Сидоров', 'Николай'),
       ('Иванов', 'Иван');

SELECT *
FROM author;

-- СВЯЗУЮЩАЯ ТАБЛИЦА

CREATE TABLE book_author (
    book_id   BIGINT,
    author_id BIGINT,

    CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author (id) ON DELETE CASCADE
);

INSERT INTO book_author (book_id, author_id)
VALUES (1, 1),
       (1, 3),
       (2, 2),
       (3, 2),
       (3, 3);

SELECT *
FROM book_author;

-- Книги + издательства

SELECT b.name, b.date, p.name
FROM book b
         JOIN publisher p ON b.publisher_id = p.id;