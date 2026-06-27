SELECT *
FROM `ai_student_impact_dataset (1)`;

CREATE TABLE ai_student_impact_data
LIKE `ai_student_impact_dataset (1)`;

INSERT ai_student_impact_data
SELECT *
FROM `ai_student_impact_dataset (1)`;




SELECT *
FROM ai_student_impact_data;


SELECT *,
ROW_NUMBER()
OVER(PARTITION BY Student_ID,Major_Category,Year_of_Study) AS row_num
FROM ai_student_impact_data;

WITH Duplicates_CTE AS
(SELECT *,
ROW_NUMBER()
OVER(PARTITION BY Student_ID,Major_Category,Year_of_Study) AS row_num
FROM ai_student_impact_data
)
SELECT *
FROM Duplicates_CTE
WHERE row_num = 1;


SELECT Student_ID,Weekly_GenAI_Hours,Primary_Use_Case
FROM ai_student_impact_data
WHERE Weekly_GenAI_Hours >=21;


SELECT Burnout_Risk_Level, COUNT(*) AS Student_count
FROM ai_student_impact_data
group by Burnout_Risk_Level;


SELECT Burnout_Risk_Level, COUNT(*) AS Student_count
FROM ai_student_impact_data
WHERE Weekly_GenAI_Hours >=21
group by Burnout_Risk_Level;


SELECT *
FROM ai_student_impact_data;


SELECT Weekly_GenAI_Hours, COUNT(*) AS Student_count
FROM ai_student_impact_data
WHERE Perceived_AI_Dependency > 3 
AND Weekly_GenAI_Hours >=35 
GROUP BY Weekly_GenAI_Hours ;


SELECT Weekly_GenAI_Hours,COUNT(*) AS student_count
FROM ai_student_impact_data
WHERE Perceived_AI_Dependency > 3 
AND Weekly_GenAI_Hours >=35 
GROUP BY Weekly_GenAI_Hours ;

SELECT 
  CASE 
    WHEN Weekly_GenAI_Hours >= 21 THEN 'High'
    WHEN Weekly_GenAI_Hours >= 7 THEN 'Medium'
    ELSE 'Low'
  END AS GenAI_Bracket,
  AVG(Perceived_AI_Dependency) AS Avg_Dependency
FROM ai_student_impact_data
GROUP BY GenAI_Bracket;

-- GenAI usage relation with GPA improvement

SELECT
CASE
WHEN Weekly_GenAI_Hours >=35 THEN 'High'
WHEN Weekly_GenAI_Hours >=14 THEN 'Medium'
ELSE 'Low'
END AS GenAI_usage_Bracket,
COUNT(Post_Semester_GPA - Pre_Semester_GPA) AS Improvment
FROM ai_student_impact_data
WHERE Post_Semester_GPA > Pre_Semester_GPA
GROUP BY GenAI_usage_Bracket;



-- Anxiety and GenAI usage

SELECT
CASE
WHEN Weekly_GenAI_Hours >= 35 THEN "High_usage"
WHEN Weekly_GenAI_Hours >= 21 THEN "Medium_usage"
ELSE "Low_usage"
END AS GenAI_usage_Bracket,
AVG(Anxiety_Level_During_Exams) AS Anxiety_value
FROM ai_student_impact_data
GROUP BY GenAI_usage_Bracket;




-- Subscription and gpa improvement relationship


SELECT Paid_Subscription, COUNT(Post_Semester_GPA-Pre_Semester_GPA) AS Improvement
FROM ai_student_impact_data
GROUP BY Paid_Subscription;




-- DIfferent major ai usage along with study hours

SELECT Major_Category,AVG(Traditional_Study_Hours),AVG(Weekly_GenAI_Hours)
FROM ai_student_impact_data
GROUP BY Major_Category;













