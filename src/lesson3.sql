-- ИЗДАТЕЛЬСТВА

CREATE TABLE publisher (
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name    VARCHAR(200),
    address VARCHAR(200)
);

INSERT INTO publisher (name, address)
VALUES ('Эксмо', 'Санкт-Петербург'),
       ('АСТ', 'Москва');

SELECT name    AS "Название издательства",
       address AS "Адрес"
FROM publisher;

-- КНИГИ

CREATE TABLE book (
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(200),
    date         DATE,
    publisher_id BIGINT,

    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (id)
);

INSERT INTO book (name, date, publisher_id)
VALUES ('Книга 1', '2015-01-25', 1),
       ('Книга 2', '2023-10-26', 1),
       ('Книга 3', '2020-03-07', 2);

SELECT *
FROM book;

-- АВТОРЫ

CREATE TABLE author (
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    surname VARCHAR(100),
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

    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book (id),
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author (id)
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