create database learnpulse;
use learnpulse;
SELECT * FROM students LIMIT 5;
SELECT 
    COUNT(*) AS total_students,
    ROUND(AVG(study_hours),2) AS avg_study_hours,
    ROUND(AVG(productivity_score),2) AS avg_productivity,
    ROUND(AVG(engagement_score),2) AS avg_engagement,
    ROUND(AVG(focus_score),2) AS avg_focus
FROM students;
-- Q2
SELECT 
    burnout_risk,
    COUNT(*) AS total_students
FROM students
GROUP BY burnout_risk;
-- Q3
SELECT 
    user_id,
    productivity_score,
    study_hours,
    engagement_score
FROM students
ORDER BY productivity_score DESC
LIMIT 10;
-- Q4
SELECT 
    CASE
        WHEN profile_overachiever = 1 THEN 'Overachiever'
        WHEN profile_struggling = 1 THEN 'Struggling'
        ELSE 'Consistent'
    END AS student_profile,

    ROUND(AVG(productivity_score),2) AS avg_productivity,
    ROUND(AVG(focus_score),2) AS avg_focus,
    ROUND(AVG(engagement_score),2) AS avg_engagement,
    ROUND(AVG(consistency_index),2) AS avg_consistency

FROM students

GROUP BY student_profile;
-- Q5
SELECT 
    user_id,
    productivity_score,
    burnout_risk,
    study_hours,
    breaks
FROM students
WHERE burnout_risk = 1
ORDER BY productivity_score DESC;
-- Q7
SELECT 
    ROUND(study_hours,1) AS study_hour_bucket,
    ROUND(AVG(productivity_score),2) AS avg_productivity
FROM students
GROUP BY study_hour_bucket
ORDER BY study_hour_bucket;
-- Q8
SELECT 
    CASE
        WHEN focus_trend > 5 THEN 'Rapid Improvement'
        WHEN focus_trend BETWEEN 0 AND 5 THEN 'Stable Growth'
        ELSE 'Declining Focus'
    END AS focus_category,

    COUNT(*) AS total_students

FROM students

GROUP BY focus_category;
-- Q9
SELECT 
    user_id,
    learning_efficiency,
    productivity_per_hour,
    consistency_index
FROM students
ORDER BY learning_efficiency DESC
LIMIT 15;
-- Q10
SELECT 
    ROUND(consistency_index,0) AS consistency_level,
    ROUND(AVG(productivity_score),2) AS avg_productivity
FROM students
GROUP BY consistency_level
ORDER BY consistency_level;
-- Q11
SELECT 
    healthy_learning_pattern,
    COUNT(*) AS total_students,
    ROUND(AVG(productivity_score),2) AS avg_productivity
FROM students
GROUP BY healthy_learning_pattern;
-- Q12
SELECT 
    break_overload,
    ROUND(AVG(productivity_score),2) AS avg_productivity,
    ROUND(AVG(focus_score),2) AS avg_focus,
    ROUND(AVG(engagement_score),2) AS avg_engagement
FROM students
GROUP BY break_overload;
-- Q13
SELECT 
    user_id,
    engagement_score,
    completed_videos,
    active_days,
    streak_length
FROM students
ORDER BY engagement_score DESC
LIMIT 20;
-- Q14
SELECT 
    positive_momentum,
    ROUND(AVG(completion_status)*100,2) AS completion_rate
FROM students
GROUP BY positive_momentum;
-- Q15
SELECT 
    CASE
        WHEN productivity_score >= 75 
             AND engagement_score >= 75
             THEN 'Elite Learners'

        WHEN burnout_risk = 1
             AND productivity_score >= 60
             THEN 'Burnout Risk Performers'

        WHEN consistency_index < 40
             THEN 'Irregular Learners'

        ELSE 'Average Learners'
    END AS student_segment,

    COUNT(*) AS total_students

FROM students

GROUP BY student_segment;
