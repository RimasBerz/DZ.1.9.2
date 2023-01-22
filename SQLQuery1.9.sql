CREATE OR REPLACE VIEW TakeBooks2 AS 
SELECT c.id_teacher,c.id_book,c.date_in,c.date_out,b.id AS book_id,b.id_author,b.id_category,t.id AS teacher_id,t.lastname

FROM ((Book b 
JOIN T_Cards c
ON c.id_book = b.id)
JOIN Teacher t
ON c.id_teacher = t.id)
WHERE c.date_out IS NULL

CREATE OR REPLACE VIEW TakeBooks3 AS 
SELECT c.id_student,c.id_book,c.date_in,c.date_out,b.id AS book_id,b.id_author,b.id_category

FROM ((Book b 
JOIN S_Cards c
ON c.id_book = b.id)
JOIN Student s
ON c.id_student = s.id)
WHERE c.date_out IS NULL


CREATE OR REPLACE VIEW TakeBooks4 AS 
SELECT TOP(1) c.id_teacher,c.id_book,c.date_in,c.date_out,b.id AS book_id,b.id_author,b.id_category,t.id AS teacher_id,t.lastname,SUM(c.id_librarian + s.id_librarian)

FROM ((Book b 
JOIN T_Cards c
ON c.id_book = b.id)
JOIN Teacher t
ON c.id_teacher = t.id)
JOIN S_Cards s
ON s.id = c.id
WHERE c.date_in IS NULL
GROUP BY c.id_teacher,c.id_book,c.date_in,c.date_out,b.id,b.id_author,b.id_category,t.id ,t.lastname
HAVING SUM(c.id_librarian + s.id_librarian) > 0
ORDER BY SUM(c.id_librarian + s.id_librarian) DESC


CREATE OR REPLACE VIEW TakeBooks5 AS 
SELECT TOP(1) c.id_teacher,c.id_book,c.date_in,c.date_out,b.id AS book_id,b.id_author,b.id_category,t.id AS teacher_id,t.lastname,SUM(c.date_in + s.date_out)

FROM ((Book b 
JOIN T_Cards c
ON c.id_book = b.id)
JOIN Teacher t
ON c.id_teacher = t.id)
JOIN S_Cards s
ON s.id = c.id
WHERE c.date_in IS NULL
GROUP BY c.id_teacher,c.id_book,c.date_in,c.date_out,b.id,b.id_author,b.id_category,t.id ,t.lastname
HAVING SUM(c.date_in + s.date_out) > 0
ORDER BY SUM(c.date_in + s.date_out) DESC
