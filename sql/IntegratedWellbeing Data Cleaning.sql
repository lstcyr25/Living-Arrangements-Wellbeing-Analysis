 ---------------------------------------------------
--- Personal Data Analytics Portfolio Project ---
---------------------------------------------------

--- This Dataset is analyzing the different aspects that affects an individuals wellbeing ---
--- whether that be living arrangements, stress, lifestyle habits, etc. ---


-- 1. Viewing the Raw Data --

SELECT *
FROM dbo.IntegratedWellbeingSurvey

/*
	--- 2. Cleaning the Raw Data --
--- This stage may involve taking the data and placing it in a staging area where it can be transformed without affecting the raw data---

		Cleaning Steps
		1. Created Staging Area
		2. Perform structural audit (row count, null counts, distinct counts)
		3. Remove exact duplicates
		4. Trim and standardize text fields
		5. Normalize Null and Blank Values
		6. Rename survey-question columns to analytical column names
		7. Validate and convert data types
		8. Perform logical range validation
		9. Remove or flag unusable rows/columns

*/


--- 1. Creating Staging Area
SELECT *
INTO dbo.IntegratedWellbeingSurvey_Staging
FROM dbo.IntegratedWellbeingSurvey


SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging


--- 2. Perform Structural Audit


-- Row Count
SELECT COUNT(*) AS Total_Rows
FROM dbo.IntegratedWellbeingSurvey_Staging


-- Null Count Per Column
SELECT 
    SUM(CASE WHEN [Sleep Duration] IS NULL THEN 1 ELSE 0 END) AS SleepDuration_Nulls,
    SUM(CASE WHEN [Quality of Sleep] IS NULL THEN 1 ELSE 0 END) AS QualityOfSleep_Nulls,
    SUM(CASE WHEN [Stress Level] IS NULL THEN 1 ELSE 0 END) AS StressLevel_Nulls,
    SUM(CASE WHEN [Age] IS NULL THEN 1 ELSE 0 END) AS Age_Nulls,
    SUM(CASE WHEN [Married] IS NULL THEN 1 ELSE 0 END) AS Married_Nulls,
    SUM(CASE WHEN [Number_children] IS NULL THEN 1 ELSE 0 END) AS NumChild_Nulls,
    SUM(CASE WHEN [total_members] IS NULL THEN 1 ELSE 0 END) AS totalmembers_Nulls,
    SUM(CASE WHEN [How are you feeling right now?] IS NULL THEN 1 ELSE 0 END) AS Feeling_Nulls,
    SUM(CASE WHEN [On a scale of 1-100, how would you express this feeling?] IS NULL THEN 1 ELSE 0 END) AS FeelingScale_Nulls,
    SUM(CASE WHEN [Are you happy with your financial state?] IS NULL THEN 1 ELSE 0 END) AS Finances_Nulls,
    SUM(CASE WHEN [Understanding with your family members?] IS NULL THEN 1 ELSE 0 END) AS FamilyUnderstanding_Nulls,
    SUM(CASE WHEN [Are you feeling pressure in your study or work right now?] IS NULL THEN 1 ELSE 0 END) AS Pressure_Nulls,
    SUM(CASE WHEN [Are you happy with your living place?] IS NULL THEN 1 ELSE 0 END) AS Livingplace_Nulls,
    SUM(CASE WHEN [Who supports you when you are not succeeding in your  life?] IS NULL THEN 1 ELSE 0 END) AS Sucession_Nulls,
    SUM(CASE WHEN [Have you used any social media within the last 6 hours?] IS NULL THEN 1 ELSE 0 END) AS SocialMediaUse_Nulls,
    SUM(CASE WHEN [Do you have inferiority complex?] IS NULL THEN 1 ELSE 0 END) AS Complex_Nulls,
    SUM(CASE WHEN [Are you satisfied with your meal today?] IS NULL THEN 1 ELSE 0 END) AS MealSatisfaction_Nulls,
    SUM(CASE WHEN [Are you feeling sick/health issues today?] IS NULL THEN 1 ELSE 0 END) AS Health_Nulls,
    SUM(CASE WHEN [Have you done any recreational activity (sports, gaming, hobby e] IS NULL THEN 1 ELSE 0 END) AS Rec_Nulls,
    SUM(CASE WHEN [How long did you sleep last night?(in hours)] IS NULL THEN 1 ELSE 0 END) AS SleepHours_Nulls,
    SUM(CASE WHEN [Educational Level] IS NULL THEN 1 ELSE 0 END) AS Education_Nulls,
    SUM(CASE WHEN [Little interest or pleasure in doing things] IS NULL THEN 1 ELSE 0 END) AS Interest_Nulls,
    SUM(CASE WHEN [Feeling down, depressed, or hopeless] IS NULL THEN 1 ELSE 0 END) AS Emotional_Nulls,
    SUM(CASE WHEN [Trouble falling or staying asleep, or sleeping too much] IS NULL THEN 1 ELSE 0 END) AS Sleep_Nulls,
    SUM(CASE WHEN [Feeling tired or having little energy] IS NULL THEN 1 ELSE 0 END) AS Energy_Nulls,
    SUM(CASE WHEN [Poor appetite or overeating] IS NULL THEN 1 ELSE 0 END) AS Eating_Nulls,
    SUM(CASE WHEN [Feeling bad about yourself or that you are a failure or not have] IS NULL THEN 1 ELSE 0 END) AS Failure_Nulls,
    SUM(CASE WHEN [Trouble concentrating on things, such as reading the newspaper o] IS NULL THEN 1 ELSE 0 END) AS Concentration_Nulls,
    SUM(CASE WHEN [Moving or speaking so slowly that other people could have notice] IS NULL THEN 1 ELSE 0 END) AS Communication_Nulls,
    SUM(CASE WHEN [Thoughts that you would be better off dead or of hurting yoursel] IS NULL THEN 1 ELSE 0 END) AS SelfHarm_Nulls,
    SUM(CASE WHEN [Do you have part-time or full-time job?] IS NULL THEN 1 ELSE 0 END) AS JobType_Nulls,
    SUM(CASE WHEN [Which of the following best describes your term-time accommodati] IS NULL THEN 1 ELSE 0 END) AS TermTime_Nulls,
    SUM(CASE WHEN [How many hours do you spend studying each day?] IS NULL THEN 1 ELSE 0 END) AS StudyHours_Nulls,
    SUM(CASE WHEN [How many of the electronic gadgets (e#g# mobile phone, computer,] IS NULL THEN 1 ELSE 0 END) AS NumElect_Nulls,
    SUM(CASE WHEN [How many hours do you spend on social media per day?] IS NULL THEN 1 ELSE 0 END) AS SocialMediaHours_Nulls,
    SUM(CASE WHEN [depressed] IS NULL THEN 1 ELSE 0 END) AS depressed_Nulls,
    SUM(CASE WHEN [new dep] IS NULL THEN 1 ELSE 0 END) AS Newdep_Nulls,
    SUM(CASE WHEN [dep2] IS NULL THEN 1 ELSE 0 END) AS Dep2_Nulls,
    SUM(CASE WHEN [Sleep Disorder] IS NULL THEN 1 ELSE 0 END) AS Disorder_Nulls
FROM dbo.IntegratedWellbeingSurvey_Staging;



--- 3. Check Duplicate Rows
SELECT COUNT(*) AS TotalRows
FROM dbo.IntegratedWellbeingSurvey_Staging;



SELECT COUNT(*) AS DistinctRows
FROM (
    SELECT DISTINCT *
    FROM dbo.IntegratedWellbeingSurvey_Staging
) AS Sub;


WITH DuplicateCheck AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   [Sleep Duration],
                   [Quality of Sleep],
                   [Stress Level],
                   [BMI Category],
                   [Heart Rate],
                   [Blood Pressure],
                   [Physical Activity Level],
                   [Daily Steps],
                   [sex],
                   [Age],
                   [Married],
                   [Number_children],
                   [total_members],
                   [How are you feeling right now?],
                   [On a scale of 1-100, how would you express this feeling?],
                   [Are you happy with your financial state?],
                   [Understanding with your family members?],
                   [Are you feeling pressure in your study or work right now?],
                   [Are you happy with your living place?],
                   [Who supports you when you are not succeeding in your  life?],
                   [Have you used any social media within the last 6 hours?],
                   [Do you have inferiority complex?],
                   [Are you satisfied with your meal today?],
                   [Are you feeling sick/health issues today?],
                   [Have you done any recreational activity (sports, gaming, hobby e],
                   [How long did you sleep last night?(in hours)],
                   [Educational Level],
                   [Little interest or pleasure in doing things],
                   [Feeling down, depressed, or hopeless],
                   [Trouble falling or staying asleep, or sleeping too much],
                   [Feeling tired or having little energy],
                   [Poor appetite or overeating],
                   [Feeling bad about yourself or that you are a failure or not have],
                   [Trouble concentrating on things, such as reading the newspaper o],
                   [Moving or speaking so slowly that other people could have notice],
                   [Thoughts that you would be better off dead or of hurting yoursel],
                   [Do you have part-time or full-time job?],
                   [Which of the following best describes your term-time accommodati],
                   [How many hours do you spend studying each day?],
                   [How many of the electronic gadgets (e#g# mobile phone, computer,],
                   [How many hours do you spend on social media per day?],
                   [depressed],
                   [new dep],
                   [dep2],
                   [Sleep Disorder]
               ORDER BY (SELECT NULL)
           ) AS RowNum
    FROM dbo.IntegratedWellbeingSurvey_Staging
)
SELECT *
FROM DuplicateCheck
WHERE RowNum > 1;



--- Delete Duplicate Rows
WITH DuplicateCheck AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   [Sleep Duration],
                   [Quality of Sleep],
                   [Stress Level],
                   [BMI Category],
                   [Heart Rate],
                   [Blood Pressure],
                   [Physical Activity Level],
                   [Daily Steps],
                   [sex],
                   [Age],
                   [Married],
                   [Number_children],
                   [total_members],
                   [How are you feeling right now?],
                   [On a scale of 1-100, how would you express this feeling?],
                   [Are you happy with your financial state?],
                   [Understanding with your family members?],
                   [Are you feeling pressure in your study or work right now?],
                   [Are you happy with your living place?],
                   [Who supports you when you are not succeeding in your  life?],
                   [Have you used any social media within the last 6 hours?],
                   [Do you have inferiority complex?],
                   [Are you satisfied with your meal today?],
                   [Are you feeling sick/health issues today?],
                   [Have you done any recreational activity (sports, gaming, hobby e],
                   [How long did you sleep last night?(in hours)],
                   [Educational Level],
                   [Little interest or pleasure in doing things],
                   [Feeling down, depressed, or hopeless],
                   [Trouble falling or staying asleep, or sleeping too much],
                   [Feeling tired or having little energy],
                   [Poor appetite or overeating],
                   [Feeling bad about yourself or that you are a failure or not have],
                   [Trouble concentrating on things, such as reading the newspaper o],
                   [Moving or speaking so slowly that other people could have notice],
                   [Thoughts that you would be better off dead or of hurting yoursel],
                   [Do you have part-time or full-time job?],
                   [Which of the following best describes your term-time accommodati],
                   [How many hours do you spend studying each day?],
                   [How many of the electronic gadgets (e#g# mobile phone, computer,],
                   [How many hours do you spend on social media per day?],
                   [depressed],
                   [new dep],
                   [dep2],
                   [Sleep Disorder]
               ORDER BY (SELECT NULL)
           ) AS RowNum
    FROM dbo.IntegratedWellbeingSurvey_Staging
)
DELETE FROM DuplicateCheck
WHERE RowNum > 1;


SELECT COUNT(*) AS TotalRows
FROM dbo.IntegratedWellbeingSurvey_Staging;



SELECT COUNT(*) AS DistinctRows
FROM (
    SELECT DISTINCT *
    FROM dbo.IntegratedWellbeingSurvey_Staging
) AS Sub;


SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging

--- 4. Trim and Standardize Text Fields
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'IntegratedWellbeingSurvey_Staging'
AND DATA_TYPE IN ('varchar', 'nvarchar');


UPDATE dbo.IntegratedWellbeingSurvey_Staging
SET 
    [BMI Category] = LTRIM(RTRIM([BMI Category])),
    [Blood Pressure] = LTRIM(RTRIM([Blood Pressure])),
    [How are you feeling right now?] = LTRIM(RTRIM([How are you feeling right now?])),
    [Are you happy with your financial state?] = LTRIM(RTRIM([Are you happy with your financial state?])),
    [Understanding with your family members?] = LTRIM(RTRIM([Understanding with your family members?])),
    [Are you feeling pressure in your study or work right now?] = LTRIM(RTRIM([Are you feeling pressure in your study or work right now?])),
    [Are you happy with your living place?] = LTRIM(RTRIM([Are you happy with your living place?])),
    [Who supports you when you are not succeeding in your  life?] = LTRIM(RTRIM([Who supports you when you are not succeeding in your  life?])),
    [Have you used any social media within the last 6 hours?] = LTRIM(RTRIM([Have you used any social media within the last 6 hours?])),
    [Do you have inferiority complex? ] = LTRIM(RTRIM([Do you have inferiority complex? ])),
    [Are you satisfied with your meal today?] = LTRIM(RTRIM([Are you satisfied with your meal today?])),
    [Are you feeling sick/health issues today?] = LTRIM(RTRIM([Are you feeling sick/health issues today?])),
    [Have you done any recreational activity (sports, gaming, hobby e] = LTRIM(RTRIM([Have you done any recreational activity (sports, gaming, hobby e])),
    [Educational Level] = LTRIM(RTRIM([Educational Level])),
    [Do you have part-time or full-time job? ] = LTRIM(RTRIM([Do you have part-time or full-time job? ])),
    [Which of the following best describes your term-time accommodati] = LTRIM(RTRIM([Which of the following best describes your term-time accommodati])),
    [How many hours do you spend studying each day?] = LTRIM(RTRIM([How many hours do you spend studying each day?])),
    [How many hours do you spend on social media per day?] = LTRIM(RTRIM([How many hours do you spend on social media per day?])),
    [Sleep Disorder] = LTRIM(RTRIM([Sleep Disorder]));


SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging


SELECT Distinct [BMI Category]
FROM dbo.IntegratedWellbeingSurvey_Staging


UPDATE dbo.IntegratedWellbeingSurvey_Staging
SET [BMI Category] = 'Normal'
WHERE LOWER([BMI Category]) IN ('normal weight');


--- 5. Normalize Null and Blank Values
SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging


UPDATE dbo.IntegratedWellbeingSurvey_Staging
SET 
    [BMI Category] = NULLIF([BMI Category], ''),
    [Blood Pressure] = NULLIF([Blood Pressure], ''),
    [Are you happy with your financial state?] = NULLIF([Are you happy with your financial state?], ''),
    [Understanding with your family members?] = NULLIF([Understanding with your family members?], ''),
    [Are you feeling pressure in your study or work right now?] = NULLIF([Are you feeling pressure in your study or work right now?], ''),
    [Are you happy with your living place?] = NULLIF([Are you happy with your living place?], ''),
    [Who supports you when you are not succeeding in your  life?] = NULLIF([Who supports you when you are not succeeding in your  life?], ''),
    [Have you used any social media within the last 6 hours?] = NULLIF([Have you used any social media within the last 6 hours?], ''),
    [Do you have inferiority complex? ] = NULLIF([Do you have inferiority complex? ], ''),
    [Are you satisfied with your meal today?] = NULLIF([Are you satisfied with your meal today?], ''),
    [Are you feeling sick/health issues today?] = NULLIF([Are you feeling sick/health issues today?], ''),
    [Have you done any recreational activity (sports, gaming, hobby e] = NULLIF([Have you done any recreational activity (sports, gaming, hobby e], ''),
    [Educational Level] = NULLIF([Educational Level], ''),
    [Do you have part-time or full-time job? ] = NULLIF([Do you have part-time or full-time job? ], ''),
    [Which of the following best describes your term-time accommodati] = NULLIF([Which of the following best describes your term-time accommodati], ''),
    [How many hours do you spend studying each day?] = NULLIF([How many hours do you spend studying each day?], ''),
    [How many hours do you spend on social media per day?] = NULLIF([How many hours do you spend on social media per day?], ''),
    [Sleep Disorder] = NULLIF([Sleep Disorder], '');


--- 6. Converting Survey Questions to Analytical Names
SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[How are you feeling right now?]', 
    'current_mood', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[On a scale of 1-100, how would you express this feeling?]', 
    'happiness_score', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Are you happy with your financial state?]', 
    'financial_satisfaction', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Understanding with your family members?]', 
    'family_relationship_quality', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Are you feeling pressure in your study or work right now?]', 
    'study_work_pressure', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Are you happy with your living place?]', 
    'housing_satisfaction', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Who supports you when you are not succeeding in your  life?]', 
    'support_system', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Have you used any social media within the last 6 hours?]', 
    'recent_social_media_use', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Do you have inferiority complex? ]', 
    'inferiority_complex', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Are you satisfied with your meal today?]', 
    'meal_satisfaction', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Are you feeling sick/health issues today?]', 
    'current_health_issue', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Educational Level]', 
    'education_level', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Do you have part-time or full-time job? ]', 
    'employment_status', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[How many hours do you spend studying each day?]', 
    'study_hours_daily', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[How many hours do you spend on social media per day?]', 
    'social_media_hours_daily', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Which of the following best describes your term-time accommodati]', 
    'living_arrangements', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Have you done any recreational activity (sports, gaming, hobby e]', 
    'recreational_activity', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[How long did you sleep last night?(in hours)]', 
    'sleep_hours_last_night', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Little interest or pleasure in doing things]', 
    'phq_interest_loss', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Feeling down, depressed, or hopeless]', 
    'phq_depressed_mood', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Trouble falling or staying asleep, or sleeping too much]', 
    'phq_sleep_issue', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Feeling tired or having little energy]', 
    'phq_fatigue', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Poor appetite or overeating]', 
    'phq_appetite_issue', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Feeling bad about yourself or that you are a failure or not have]', 
    'phq_low_self_worth', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Trouble concentrating on things, such as reading the newspaper o]', 
    'phq_concentration_issue', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Moving or speaking so slowly that other people could have notice]', 
    'phq_psychomotor_change', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[Thoughts that you would be better off dead or of hurting yoursel]', 
    'phq_self_harm_thoughts', 
    'COLUMN';

EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[How many of the electronic gadgets (e#g# mobile phone, computer,]', 
    'electronic_device_count', 
    'COLUMN';

-- Fixing Column Names With Spaces
EXEC sp_rename 
    'dbo.IntegratedWellbeingSurvey_Staging.[new dep]', 
    'new_dep', 
    'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Sleep Duration]', 
'Sleep_Duration', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Quality of Sleep]', 
'Quality_of_Sleep', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Stress Level]', 
'Stress_Level', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[BMI Category]', 
'BMI_Category', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Heart Rate]', 
'Heart_Rate', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Blood Pressure]', 
'Blood_Pressure', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Physical Activity Level]', 
'Physical_Activity_Level', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Daily Steps]', 
'Daily_Steps', 
'COLUMN';

EXEC sp_rename 
'dbo.IntegratedWellbeingSurvey_Staging.[Sleep Disorder]', 
'Sleep_Disorder', 
'COLUMN';

SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging


--- 7. Validate and Convert Data Types
SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'IntegratedWellbeingSurvey_Staging'


-- Validating INT Conversions
SELECT Age FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE TRY_CAST(Age AS INT) IS NULL AND Age IS NOT NULL;

SELECT sex FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE TRY_CAST(sex AS INT) IS NULL AND sex IS NOT NULL;

SELECT Married FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE TRY_CAST(Married AS INT) IS NULL AND Married IS NOT NULL;

SELECT Number_children FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE TRY_CAST(Number_children AS INT) IS NULL AND Number_children IS NOT NULL;

SELECT total_members FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE TRY_CAST(total_members AS INT) IS NULL AND total_members IS NOT NULL;

-- Converting to INT
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN Age INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN sex INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN Married INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN Number_children INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN total_members INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_interest_loss INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_depressed_mood INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_sleep_issue INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_fatigue INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_appetite_issue INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_low_self_worth INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_concentration_issue INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_psychomotor_change INT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN phq_self_harm_thoughts INT;

-- Converting Binary Columns to BIT
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN depressed BIT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN new_dep BIT;
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging ALTER COLUMN dep2 BIT;


--- Step 8. Logical Range Validation
-- Checking if values make real world sense
SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging

-- Flag Column
ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging
ADD validation_flag NVARCHAR(255);

-- Logical Range SQL Code
UPDATE dbo.IntegratedWellbeingSurvey_Staging
SET validation_flag = 'OUT_OF_RANGE'
WHERE
    Age NOT BETWEEN 15 AND 80
    OR Sleep_Duration NOT BETWEEN 0 AND 24
    OR sleep_hours_last_night NOT BETWEEN 0 AND 24
    OR Quality_of_Sleep NOT BETWEEN 1 AND 10
    OR Stress_Level NOT BETWEEN 1 AND 10
    OR Heart_Rate NOT BETWEEN 30 AND 220
    OR Physical_Activity_Level NOT BETWEEN 30 AND 90
    OR Daily_Steps NOT BETWEEN 0 AND 50000
    OR happiness_score NOT BETWEEN 1 AND 100
    OR phq_interest_loss NOT BETWEEN 1 AND 4
    OR phq_depressed_mood NOT BETWEEN 1 AND 4
    OR phq_sleep_issue NOT BETWEEN 1 AND 4
    OR phq_fatigue NOT BETWEEN 1 AND 4
    OR phq_appetite_issue NOT BETWEEN 1 AND 4
    OR phq_low_self_worth NOT BETWEEN 1 AND 4
    OR phq_concentration_issue NOT BETWEEN 1 AND 4
    OR phq_psychomotor_change NOT BETWEEN 1 AND 4
    OR phq_self_harm_thoughts NOT BETWEEN 1 AND 4
    OR depressed NOT IN (0,1)
    OR new_dep NOT IN (0,1)
    OR dep2 NOT IN (0,1);

SELECT validation_flag, COUNT(*)
FROM dbo.IntegratedWellbeingSurvey_Staging
GROUP BY validation_flag;


--- Step 9. Remove or flag unusable rows/columns
SELECT *
FROM dbo.IntegratedWellbeingSurvey_Staging

ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging
DROP COLUMN electronic_device_count;

ALTER TABLE dbo.IntegratedWellbeingSurvey_Staging
DROP COLUMN new_dep;

-----------------------------------------------------
------------- Final Clean Table ---------------------
-----------------------------------------------------
SELECT *
INTO dbo.IntegratedWellbeingSurvey_Final
FROM dbo.IntegratedWellbeingSurvey_Staging
WHERE validation_flag IS NULL;

SELECT *
FROM dbo.IntegratedWellbeingSurvey_Final;

ALTER TABLE dbo.IntegratedWellbeingSurvey_Final
ADD ID INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE dbo.IntegratedWellbeingSurvey_Final
ADD phq_total INT;

UPDATE dbo.IntegratedWellbeingSurvey_Final
SET phq_total =
    phq_interest_loss +
    phq_depressed_mood +
    phq_sleep_issue +
    phq_fatigue +
    phq_appetite_issue +
    phq_low_self_worth +
    phq_concentration_issue +
    phq_psychomotor_change +
    phq_self_harm_thoughts;


