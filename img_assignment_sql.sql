CREATE DATABASE img_assignment;
USE img_assignment;

CREATE TABLE author (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE book (
	id INT PRIMARY KEY,
    title VARCHAR(255),
    category VARCHAR(255)
);

CREATE TABLE student (
	id INT PRIMARY KEY,
    sname VARCHAR(255),
    dept VARCHAR(255)
);

CREATE TABLE writee (
	author_id INT,
	book_id INT,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (book_id) REFERENCES book(id)
);

CREATE TABLE borrow (
	student_id INT,
	book_id INT,
    checkout_time INT,
    return_time INT,
    PRIMARY KEY (student_id, book_id, checkout_time),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (book_id) REFERENCES book(id)
);

INSERT INTO author (id, name) VALUES
(1, 'Samrat Middha'),
(2, 'Bhoomi Bonal');

INSERT INTO book (id, title, category) VALUES
(1, 'Book1', 'Fiction'),
(2, 'Book2', 'Political Fiction'),
(3, 'Book3', 'Science Fiction'),
(4, 'Book4', 'Political Fiction');

INSERT INTO student (id, sname, dept) VALUES
(1, 'Anshika Arora', 'ME'),
(2, 'Akhil Punia', 'CSE'),
(3, 'Dhairya Singhal', 'EE');

INSERT INTO writee (author_id, book_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4);

INSERT INTO borrow (student_id, book_id, checkout_time, return_time) VALUES
(1, 1, 1621468800, 1622159999),
(1, 2, 1621468800, 1622159999),
(2, 1, 1621468800, 1622159999),
(3, 3, 1621468800, 1622159999);

#query1
SELECT book.title
FROM borrow
JOIN book ON borrow.book_id = book.id
JOIN student ON borrow.student_id = student.id
WHERE student.sname = 'Anshika Arora';

#query2
SELECT COUNT(*) AS num_of_books_written
FROM writee
JOIN author ON writee.author_id = author.id
WHERE author.name = 'Samrat Middha';

#query3
SELECT * 
FROM book
ORDER BY category, title DESC
LIMIT 5;

#query4
SELECT DISTINCT student.sname
FROM borrow
JOIN book ON borrow.book_id = book.id
JOIN student ON borrow.student_id = student.id
WHERE book.category = 'Political Fiction';

#query5
SELECT sname
FROM student 
WHERE student.id NOT IN (
    SELECT DISTINCT borrow.student_id
    FROM borrow 
    JOIN writee ON borrow.book_id = writee.book_id
    JOIN author ON writee.author_id = author.id
    WHERE author.name = 'Bhoomi Bonal'
);

#query6
SELECT borrow.student_id
FROM borrow
JOIN book ON borrow.book_id = book.id
GROUP BY borrow.student_id
HAVING COUNT(DISTINCT book.category) = 1;

#query7
Select category
FROM book
GROUP BY category
HAVING COUNT(*)>1;

#query8
SELECT sname
FROM student
WHERE student.id NOT IN(
	SELECT DISTINCT borrow.student_id
    FROM borrow 
    );
    
#query9
SELECT student.sname, book.title
FROM student
JOIN borrow ON student.id = borrow.student_id
JOIN book ON borrow.book_id = book.id
WHERE borrow.checkout_time = (
    SELECT MIN(checkout_time)
    FROM borrow
    WHERE student_id = student.id
);

#query10
SELECT book.category
FROM borrow
JOIN book ON borrow.book_id = book.id
JOIN student ON borrow.student_id = student.id
WHERE student.sname = 'Akhil Punia'
GROUP BY book.category
ORDER BY COUNT(*) DESC
LIMIT 1;

	
