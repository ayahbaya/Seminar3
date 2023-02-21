 ---- query 1 -----
SELECT TO_CHAR(date_time, 'YYYY MM') AS date,
COUNT(*) FILTER (WHERE type_of_lesson = 'individual') AS individual,
COUNT(*) FILTER (WHERE type_of_lesson = 'group') AS group,
COUNT(*) FILTER (WHERE type_of_lesson = 'ensemble') AS ensemble,
COUNT(*) AS total_no_lessons
FROM
(
SELECT date_time, 'individual' AS type_of_lesson FROM individual_lesson
UNION ALL
SELECT date_time, 'group' AS type_of_lesson FROM group_lesson
UNION ALL
SELECT date_time, 'ensemble' AS type_of_lesson FROM ensemble_lesson
) AS subquery
GROUP BY TO_CHAR(date_time, 'YYYY MM');

 ---- query 2 -----
--######################################################################
--CREATE VIEW number_of_sibling AS
SELECT COUNT(r.number_of_sibling) AS number_of_student, r.number_of_sibling
FROM
(
SELECT student.student_id, COUNT(sibling.student_id) AS number_of_sibling
FROM
student FULL JOIN sibling ON sibling.student_id = student.student_id
GROUP BY student.student_id
) AS r
GROUP BY r.number_of_sibling;
 --ORDER BY r.number_of_sibling;


 ---- query 3 -----
--######################################################################
SELECT instructor_id, COUNT(instructor_id) AS no_of_lesson
FROM
(
SELECT instructor_id, date_time FROM individual_lesson
UNION ALL
SELECT instructor_id, date_time FROM group_lesson
UNION ALL
SELECT instructor_id, date_time FROM ensemble_lesson
) AS subquery
WHERE EXTRACT(MONTH FROM date_time) = 1
GROUP BY instructor_id HAVING COUNT(instructor_id) > 0;


 ---- query 4 -----
--######################################################################
 SELECT genre, COUNT(*) AS number_of_students, max_students,
(CASE
	WHEN COUNT(*) = max_students THEN 'Full booked'
	WHEN COUNT(*) = max_students - 1 THEN '1 seats left'
  WHEN COUNT(*) = max_students - 2 THEN '2 seats left'
  ELSE 'more seat is left'
END) AS avilble_seats,
date_time
FROM ensemble_lesson JOIN ensemble_students USING(ensemble_lesson_id)
WHERE date_trunc('week', current_date + interval '1 week') = date_trunc('week', date_time)
GROUP BY ensemble_lesson_id;
