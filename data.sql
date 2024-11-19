-- 1

CREATE TABLE IF NOT EXISTS authors (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	birth_date DATE DEFAULT CURRENT_DATE,
	country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS publishers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	country VARCHAR(50) NOT NULL,
	established_year DATE DEFAULT CURRENT_DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	published_date DATE DEFAULT CURRENT_DATE NOT NULL,
	price NUMERIC(10, 2) NOT NULL,
	genre VARCHAR(50),
	author_id INTEGER REFERENCES authors(id),
	publisher_id INTEGER REFERENCES publishers(id)
);

CREATE TABLE IF NOT EXISTS book_reviews (
	id SERIAL PRIMARY KEY,
	text TEXT,
	rating INTEGER NOT NULL CHECK(rating BETWEEN 1 and 5),
	review_date DATE DEFAULT CURRENT_DATE NOT NULL,
	book_id INTEGER REFERENCES books(id)
);

-- 2

INSERT INTO authors (name, birth_date, country) VALUES
('Abdulla Qodiriy', '1894-04-10', 'O‘zbekiston'),
('Abdulla Qahhor', '1907-09-17', 'O‘zbekiston'),
('Oybek', '1905-01-10', 'O‘zbekiston'),
('Shukur Xolmirzayev', '1940-06-30', 'O‘zbekiston'),
('Asqad Mukhtor', '1920-12-23', 'O‘zbekiston'),
('Pirimqul Qodirov', '1928-10-25', 'O‘zbekiston'),
('Cho‘lpon', '1897-03-10', 'O‘zbekiston'),
('Odil Yoqubov', '1926-10-22', 'O‘zbekiston'),
('O‘tkin Ergashev', '1935-05-10', 'O‘zbekiston');

INSERT INTO publishers (name, country, established_year) VALUES
('G‘afur G‘ulom nashriyoti', 'O‘zbekiston', '1950-01-01'),
('Yangi asr avlodi', 'O‘zbekiston', '2000-01-01'),
('Adib nashriyoti', 'O‘zbekiston', '1995-01-01'),
('Cholpon nashriyoti', 'O‘zbekiston', '1990-01-01'),
('O‘zbekiston nashriyoti', 'O‘zbekiston', '1940-01-01');

INSERT INTO books (title, published_date, price, genre, author_id, publisher_id) VALUES
('O‘tkan kunlar', '1926-01-01', 15000.50, 'Roman', 1, 1),
('Mehrobdan chayon', '1928-01-01', 14000.00, 'Roman', 1, 2),
('Qutlug‘ qon', '1937-01-01', 16000.20, 'Roman', 2, 3),
('Kecha va kunduz', '1934-01-01', 12000.80, 'Roman', 3, 2),
('Sarvqomat dilbarim', '1976-01-01', 13000.50, 'Roman', 4, 1),
('Chinor', '1969-01-01', 10000.00, 'Qissa', 5, 3),
('Ulug‘bek xazinasi', '1958-01-01', 18000.50, 'Tarixiy roman', 6, 4),
('Zulmat ichra nur', '1938-01-01', 11000.30, 'Qissa', 7, 5),
('Hazon rezgi', '1965-01-01', 12000.00, 'Qissa', 8, 2),
('Ikki eshik orasi', '1986-01-01', 17000.00, 'Roman', 9, 1);

INSERT INTO book_reviews (text, rating, review_date, book_id)VALUES
(NULL, 5, '2024-01-15', 1),
('Yoqdi.', 4, '2024-01-20', 2),
('Qoyil.', 5, '2024-02-10', 3),
('Ajoyib!', 5, '2024-02-15', 4),
('Yaxshi.', 4, '2024-02-18', 5);


-- 3.1

SELECT * FROM books;
SELECT * FROM authors;
SELECT * FROM publishers;

-- 3.2

SELECT title AS "Kitob nomi", published_date AS "Chiqarilgan sanasi", price AS "Narxi", genre AS "Janri" FROM books;
SELECT name AS "Ism-Familiyasi", birth_date AS "Tug'ulgan sanasi", country AS "Davlati" FROM authors;

-- 3.3

SELECT * FROM books ORDER BY price;
SELECT * FROM authors ORDER BY name;

-- 3.4

SELECT * FROM books WHERE genre = 'Roman';
SELECT * FROM authors WHERE country = 'O‘zbekiston';

-- 3.5

SELECT * FROM books LIMIT 5; 
SELECT * FROM authors FETCH FIRST 5 ROW ONLY;

-- 3.6

SELECT * FROM books WHERE genre IN ('Roman', 'Qissa');

-- 3.7

SELECT * FROM books WHERE price BETWEEN 12000.00 AND 16000.00;

-- 3.8

SELECT * FROM books WHERE title LIKE '%kun%';

-- 3.9

SELECT * FROM book_reviews WHERE text IS NULL;

-- 3.10

SELECT genre, COUNT(*) FROM books GROUP BY genre;

-- 4.1

SELECT 
	authors.name, 
	authors.country, 
	books.title, 
	books.price, 
	books.genre 
FROM authors JOIN books ON 
	authors.id = books.author_id;

-- 4.2

SELECT COUNT(*) AS "Kitoblar soni" FROM books;
SELECT SUM(price) AS "Umumiy narxi" FROM books;
SELECT AVG(price) AS "O'rtacha narx" FROM books;
SELECT MIN(price) AS "Eng arzon kitob narxi" FROM books;
SELECT MAX(price) AS "Eng qimmat kitob narxi" FROM books;

SELECT 
    authors.name AS "Muallif", 
    COUNT(books.id) AS "Kitoblari soni" 
FROM 
    books 
JOIN 
    authors ON authors.id = books.author_id 
GROUP BY 
    authors.name;

-- END --