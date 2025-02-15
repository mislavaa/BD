-- СЕТЬ КЛИНИК "ЛАКИ"

CREATE TABLE clinic (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(200) NOT NULL DEFAULT ('Лаки'),
	work_time VARCHAR(200),
	address VARCHAR(200)
);

INSERT INTO clinic (work_time, address)
VALUES ('9:00 - 20:00', 'пр-кт Луначарского, 78'),
		('9:00 - 21:00', 'пр-кт Художников, 13'),
		('Круглосуточно', 'ул. Савушкина, 115');

SELECT *
FROM clinic;

-- ХОЗЯИН

CREATE TABLE "owner" (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	surname VARCHAR(200) NOT NULL,
	name VARCHAR(200) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(100),
	clinic_id BIGINT,

	CONSTRAINT fk_owner_clinic FOREIGN KEY (clinic_id) REFERENCES clinic(id) ON DELETE SET NULL
);

INSERT INTO "owner" (surname, name, phone, email, clinic_id)
VALUES ('Иванов', 'Иван', 8888888, '8888888@mail.ru', 1),
		('Миронов', 'Мирон', 1111111, null, 3),
		('Петров', 'Тимофей', 7777777, '7777777@mail.ru', 1),
		('Васечкина', 'Елена', 6666666, '6666666@mail.ru', 1),
		('Смирнова', 'Анна', 5555555, 'smirnova@yandex.ru', 3),
		('Пушкарёва', 'Татьяна', 3333333, null, 1),
		('Борисова', 'Ольга', 9999999, '9999999@mail.ru', 2),
		('Степанов', 'Степан', 4444444, 'stepa@mail.ru', 2),
		('Тимофеева', 'Алина', 2222222, null, 2);

SELECT id, (surname, name), phone, COALESCE(email, 'not defined'), clinic_id
FROM "owner";

-- ПИТОМЦЫ

CREATE TABLE pet (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	species VARCHAR(100) NOT NULL,
	gender VARCHAR(100) NOT NULL,
	age INT,
	breed VARCHAR(100),
	owner_id BIGINT,

	CONSTRAINT fk_pet_owner FOREIGN KEY (owner_id) REFERENCES "owner"(id) ON DELETE CASCADE
);

INSERT INTO pet (name, species, gender, age, breed, owner_id)
VALUES ('Тотошка', 'Кот', 'муж', 2, 'нет', 1),
		('Вук', 'Собака', 'муж', 3, 'Вельш-корги пемброк', 3),
		('Фусяшна', 'Кот', 'жен', 5, 'нет', 3),
		('Мауриция', 'Кот', 'жен', 4, 'нет', 1),
		('Кеша', 'Попугай', 'муж', 4, 'Волнистый попугайчик', 4),
		('Тишка', 'Кот', 'муж', 8, 'Норвежская лесная', 6),
		('Малыш', 'Собака', 'муж', 7, 'Джек-рассел-терьер', 7),
		('Маркиз', 'Кот', 'муж', 6, 'нет', 5),
		('Донателло', 'Черепаха', 'муж', 5, 'Красноухая', 8),
		('Хома', 'Хомяк', 'муж', 1, 'Джунгарик', 2),
		('Мурзик', 'Кот', 'муж', 2, 'нет', 8),
		('Афа', 'Собака', 'жен', 13, 'нет', 2),
		('Стёпа', 'Кот', 'муж', 10, 'нет', 9);

SELECT *
FROM pet;

-- ВЕТЕРИНАРЫ

CREATE TABLE category (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	parent_id INT,

	CONSTRAINT fk_category FOREIGN KEY (parent_id) REFERENCES category(id) ON DELETE SET NULL
);

INSERT INTO category (name, parent_id)
	VALUES  ('Главный врач', null),
			('Суточный врач смены', 1),
			('Терапевт', 2),
			('Хирург', 2),
			('Врач ультразвуковой диагностики', 2),
			('Невролог', 2),
			('Дежурный врач', 2),
			('Старший администратор', 1),
			('Суточный администратор', 8),
			('Ассистент', 2),
			('Стажёр', 8);

CREATE TABLE vet (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	surname VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL
);

SELECT *
FROM vet
ORDER BY surname;

-- СВЯЗУЮЩАЯ ТАБЛИЦА

CREATE TABLE vet_category_clinic (
	vet_id BIGINT,
	category_id BIGINT,
	clinic_id BIGINT,

	CONSTRAINT vet_category_clinic_pkey PRIMARY KEY (vet_id, category_id, clinic_id),
	CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE SET NULL,
	CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
	CONSTRAINT fk_clinic FOREIGN KEY (clinic_id) REFERENCES clinic(id) ON DELETE CASCADE
);

-- ЗАПИСЬ

CREATE TABLE appointment (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	date TIMESTAMP CHECK (date >= CURRENT_DATE),
	reason VARCHAR(200),
	pet_id BIGINT,

	CONSTRAINT fk_pet_appointment FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE SET NULL
);

ALTER TABLE appointment
ADD COLUMN price DECIMAL(15,2) DEFAULT (-1) CHECK (price >= -1);

INSERT INTO appointment (date, reason, pet_id)
VALUES  ('2025-02-16 14:30', 'Чекап', 1),
		('2025-02-17 11:30', 'Вакцинация', 3),
		('2025-02-17 11:40', 'Вакцинация', 2),
		('2025-02-26 09:30', 'Чистка зубов', 8),
		('2025-02-17 14:30', 'УЗИ', 6),
		('2025-02-17 15:00', 'Приём терапевта', 6),
		('2025-02-18 12:30', 'Чекап', 7),
		('2025-02-18 14:30', 'Вакцинация', 4),
		('2025-02-18 14:40', 'Вакцинация', 1),
		('2025-02-16 10:30', 'Чекап', 12),
		('2025-02-18 15:00', 'Вакцинация', 12),
		('2025-02-17 16:30', 'УЗИ', 10),
		('2025-02-17 15:30', 'Приём хирурга', 13),
		('2025-02-18 14:30', 'Чекап', 4),
		('2025-02-26 14:30', 'УЗИ', 4);

UPDATE appointment
SET price = 3000
WHERE reason = 'Вакцинация'
WHERE id = 12;

SELECT *
FROM appointment
ORDER BY id;

-- СВЯЗУЮЩАЯ ТАБЛИЦА
CREATE TABLE appointment_vet (
	appointment_id BIGINT,
	vet_id BIGINT,

	CONSTRAINT appointment_vet_pkey PRIMARY KEY (appointment_id, vet_id),
	CONSTRAINT fk_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE CASCADE,
	CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE SET NULL
);

-- ЗАПРОСЫ

-- Владелец + питомец + ветка

SELECT  o.surname || ' ' || o.name AS "owner_fio", COALESCE(o.email, 'not defined'),
		p.name AS pet_name, CONCAT(p.species, ' ', p.gender, ' ', p.age, ' ', p.breed) AS pet_info,
		c.address
FROM "owner" o
JOIN pet p ON p.owner_id = o.id
JOIN clinic c ON o.clinic_id = c.id
ORDER BY o.surname;

-- Информация про врачей

SELECT  v.surname || ' ' || v.name AS vet_fio,
		cat.name,
		c.address
FROM vet v
JOIN vet_category_clinic vcc ON vcc.vet_id = v.id
JOIN category cat ON vcc.category_id = cat.id
JOIN clinic c ON vcc.clinic_id = c.id
WHERE c.id = 1
ORDER BY cat.id;

-- Информация про запись

SELECT  o.surname || ' ' || o.name AS owner_fio,
		p.name AS pet_name, CONCAT(p.species, ' ', p.gender, ' ', p.age, ' ', p.breed) AS pet_info,
		c.address,
		a.date, a.reason,
		v.surname || ' ' || v.name AS vet_fio
FROM appointment a
JOIN pet p ON a.pet_id = p.id
JOIN "owner" o ON p.owner_id = o.id
JOIN appointment_vet av ON av.appointment_id = a.id
JOIN vet v ON av.vet_id = v.id
JOIN clinic c ON o.clinic_id = c.id
WHERE c.id = 3
ORDER BY a.date;

-- Представление (получение записи посещений во всех клиниках)

SELECT * FROM appointment_view av
WHERE (SELECT id FROM clinic c WHERE av.address = c.address) = 1
ORDER BY date;

-- Статус клиента

SELECT owner_fio, address, COUNT(date) AS visit_count,
	   CASE
		  WHEN COUNT(date) <= 1 THEN 'Новый клиент'
		  WHEN COUNT(date) BETWEEN 2 AND 4 THEN 'Постоянный клиент'
		  ELSE 'VIP'
	   END AS owner_status
FROM appointment_view
GROUP BY owner_fio, address
ORDER BY visit_count;

-- Функция (самая посещаемая клиника)

CREATE FUNCTION get_visit_count_for_clinic(c_id BIGINT) RETURNS INT
AS $$
DECLARE visit_count INT;
BEGIN
	SELECT COUNT(date) INTO visit_count
	FROM appointment_view av
	WHERE (SELECT c.id FROM clinic c WHERE av.address = c.address) = c_id;

	RETURN visit_count;
END;
$$ LANGUAGE plpgsql;

SELECT id, name, address, get_visit_count_for_clinic(id)
FROM clinic
ORDER BY id;

-- NULLIF (траты каждого клиента)

SELECT  o.surname || ' ' || o.name AS owner_fio,
		SUM(NULLIF(a.price, -1)) AS total_sum
FROM "owner" o
JOIN pet p ON p.owner_id = o.id
JOIN appointment a ON a.pet_id = p.id
GROUP BY owner_fio
ORDER BY total_sum;

SELECT  o.surname || ' ' || o.name AS owner_fio,
		COALESCE(SUM(NULLIF(a.price, -1))::varchar(50), 'не оплачено') AS total_sum
FROM "owner" o
JOIN pet p ON p.owner_id = o.id
JOIN appointment a ON a.pet_id = p.id
GROUP BY owner_fio
ORDER BY total_sum;

-- Заполнение таблиц
INSERT INTO vet(surname, name)
	VALUES  ('Плешаков', 'Константин'),
			('Иванов', 'Олег'),
			('Шустов', 'Иван'),
			('Левошко', 'Мария'),
			('Манукян', 'Марат'),
			('Оторвина', 'Елена'),
			('Бекетова', 'Виктория'),
			('Зверева', 'Анна'),
			('Шивирева', 'Диана'),
			('Бурчук', 'София'),
			('Кан', 'Евгений'),
			('Зверев', 'Николай'),
			('Мищенко', 'Диана'),
			('Власов', 'Владислав'),
			('Гарасько', 'Александр'),
			('Журавлёв', 'Михаил'),
			('Кучанская', 'Виктория'),
			('Мотыль', 'Анна'),
			('Образцов', 'Илья'),
			('Олишанская', 'Евгения'),
			('Павлова', 'Светлана'),
			('Палагина', 'Валентина'),
			('Панченко', 'Владислава'),
			('Смирнова', 'Александра'),
			('Тихомирова', 'Анна'),
			('Третьякова', 'Марта'),
			('Филиппов', 'Дмитрий'),
			('Тропин', 'Григорий'),
			('Чернышёва', 'Татьяна'),
			('Шевченко', 'Виктор'),
			('Медведев', 'Пётр'),
			('Альтова', 'Виктория'),
			('Батурина', 'Ольга'),
			('Батурина', 'Анастасия');
INSERT INTO vet_category_clinic (vet_id, category_id, clinic_id)
VALUES  (1, 1, 1),
		(2, 1, 2),
		(3, 1, 3),
		(4, 2, 1),
		(5, 2, 1),
		(6, 3, 1),
		(7, 4, 1),
		(15, 5, 1),
		(6, 5, 1),
		(11, 8, 1),
		(14, 9, 1),
		(9, 10, 1),
		(10, 10, 1),
		(12, 9, 1),
		(13, 11, 1),
		(16, 4, 1),
		(17, 5, 1),
		(20, 8, 1),
		(21, 9, 1),
		(18, 10, 1),
		(25, 5, 1),
		(15, 5, 2),
		(8, 5, 2),
		(11, 8, 2),
		(14, 9, 2),
		(9, 10, 2),
		(26, 2, 2),
		(16, 4, 2),
		(17, 5, 2),
		(24, 5, 2),
		(20, 8, 2),
		(21, 9, 2),
		(23, 9, 2),
		(18, 10, 2),
		(19, 10, 2),
		(22, 11, 2),
		(27, 2, 3),
		(28, 2, 3),
		(29, 3, 3),
		(30, 4, 3),
		(33, 8, 3),
		(34, 9, 3),
		(31, 10, 3),
		(32, 10, 3),
		(5, 2, 3),
		(6, 3, 3),
		(7, 4, 3),
		(15, 5, 3),
		(23, 9, 3),
		(18, 10, 3),
		(19, 10, 3),
		(22, 11, 3);

INSERT INTO appointment_vet (appointment_id, vet_id)
VALUES  (1, 5),
		(2, 1),
		(3, 1),
		(4, 29),
		(5, 15),
		(6, 3),
		(7, 4),
		(8, 9),
		(9, 9),
		(10, 4),
		(11, 13),
		(13, 7),
		(12, 9),
		(14, 1),
		(15, 8);