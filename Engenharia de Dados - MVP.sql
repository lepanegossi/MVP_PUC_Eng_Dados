-- 1) Quais fatores influenciam a escolha entre casamento arranjado e casamento por amor?
-- Idade ao se casar

SELECT
Marriage_Type,
AVG(Age_at_Marriage) AS Avg_Age_at_Marriage
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Escolaridade

SELECT
Marriage_Type,
SUM(CASE WHEN Education_Level = 'School' THEN 1 ELSE 0 END) AS School_Education_Count,
SUM(CASE WHEN Education_Level = 'Graduate' THEN 1 ELSE 0 END) AS Graduate_Education_Count,
SUM(CASE WHEN Education_Level = 'Postgraduate' THEN 1 ELSE 0 END) AS Postgraduate_Education_Count,
SUM(CASE WHEN Education_Level = 'PhD' THEN 1 ELSE 0 END) AS PhD_Education_Count
FROM
"db-catalog". "marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Casta

SELECT
Marriage_Type,
SUM(CASE WHEN Caste_Match = 'Same' THEN 1 ELSE 0 END) AS Same_Caste_Count,
SUM(CASE WHEN Caste_Match = 'Different' THEN 1 ELSE 0 END) AS Different_Caste_Count
FROM "db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Religião

SELECT
Marriage_Type,
SUM(CASE WHEN Religion = 'Hindu' THEN 1 ELSE 0 END) AS Hindu_Count,
SUM(CASE WHEN Religion = 'Muslim' THEN 1 ELSE 0 END) AS Muslim_Count,
SUM(CASE WHEN Religion = 'Christian' THEN 1 ELSE 0 END) AS Christian_Count,
SUM(CASE WHEN Religion = 'Sikh' THEN 1 ELSE 0 END) AS Sikh_Count,
SUM(CASE WHEN Religion = 'Others' THEN 1 ELSE 0 END) AS Other_Religion_Count
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Aprovação dos Pais

SELECT
Marriage_Type,
SUM(CASE WHEN Parental_Approval = 'Yes' THEN 1 ELSE 0 END) AS Parental_Approval_Yes_Count,
SUM(CASE WHEN Parental_Approval = 'No' THEN 1 ELSE 0 END) AS Parental_Approval_No_Count,
SUM(CASE WHEN Parental_Approval = 'Partial' THEN 1 ELSE 0 END) AS Parental_Approval_Partial_Count
FROM
"db-catalog". "marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Contexto Rural/Urbano

SELECT
Marriage_Type,
SUM(CASE WHEN Urban_Rural = 'Urban' THEN 1 ELSE 0 END) AS Urban_Count,
SUM(CASE WHEN Urban_Rural = 'Rural' THEN 1 ELSE 0 END) AS Rural_Count
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- Renda

SELECT
Marriage_Type,
SUM(CASE WHEN Income_Level = 'Low' THEN 1 ELSE 0 END) AS Low_Income_Count,
SUM(CASE WHEN Income_Level = 'Middle' THEN 1 ELSE 0 END) AS Middle_Income_Count,
SUM(CASE WHEN Income_Level = 'High' THEN 1 ELSE 0 END) AS High_Income_Count
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- 2) Qual é a taxa de divórcio entre casamentos arranjados e casamentos por amor?

SELECT
Marriage_Type,
COUNT(ID) AS Total_Marriages_Registries,
SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) AS Total_Divorces,
SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(ID) AS Divorce_Rate
FROM "db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type

-- 3) De que forma fatores como renda e aprovação dos pais contribuem para o divórcio?

-- Renda

SELECT
Income_Level,
COUNT(ID) AS Total_Marriages_Registries,
SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) AS Total_Divorces,
(SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(ID)) AS Divorce_Rate
FROM
"db-catalog". "marital-dataprocessed_data"
GROUP BY
Income_Level
ORDER BY
Income_Level;

-- Aprovação dos pais

SELECT
Parental_Approval,
COUNT(ID) AS Total_Marriages_Registries,
SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) AS Total_Divorces,
(SUM(CASE WHEN Divorce_Status = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(ID)) AS Divorce_Rate
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Parental_Approval
ORDER BY
Parental_Approval;

-- 4) Como casamentos inter-castas e inter-religiosos se relacionam com o tipo de casamento?

SELECT
Marriage_Type,
COUNT(*) AS Total_Marriages,
SUM(CASE WHEN Caste_Match = 'Different' THEN 1 ELSE 0 END) AS Inter_Caste_Marriages,
SUM(CASE WHEN Inter_Religion = 'Yes' THEN 1 ELSE 0 END) AS Inter_Religion_Marriages,
ROUND(SUM(CASE WHEN Caste_Match = 'Different' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Inter_Caste_Percentage,
ROUND(SUM(CASE WHEN Inter_Religion = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Inter_Religion_Percentage
FROM
"db-catalog"."marital-dataprocessed_data"
GROUP BY
Marriage_Type;


