-- Write query to find the number of grade A's given by the teacher who has graded the most assignments
WITH topTeacher AS 
( SELECT teacher_id, COUNT(*) AS gradedCount
    FROM assignments
    WHERE state = 'GRADED'
    GROUP BY teacher_id
    ORDER BY gradedCount DESC
    LIMIT 1
),
AGrades AS 
( SELECT teacher_id, COUNT(*) AS AGradeCount
    FROM assignments
    WHERE grade = 'A' AND teacher_id = (SELECT teacher_id FROM topTeacher)
    GROUP BY teacher_id
)
SELECT AGradeCount
FROM AGrades;
