create database PanCard;

use PanCard;


-- View full dataset
SELECT *
FROM [dbo].[Copy of PAN Number Validation Dataset];


--------------------------------------------------
-- Check NULL PAN numbers
SELECT *
FROM [dbo].[Copy of PAN Number Validation Dataset]
WHERE pan_numbers IS NULL;


--------------------------------------------------
-- Check for duplicate PAN numbers
SELECT
    pan_numbers,
    COUNT(1)
FROM [dbo].[Copy of PAN Number Validation Dataset]
GROUP BY pan_numbers
HAVING COUNT(1) > 1;


--------------------------------------------------
-- Handle Leading / Trailing Spaces
SELECT *
FROM [dbo].[Copy of PAN Number Validation Dataset]
WHERE pan_numbers <> TRIM(pan_numbers);


--------------------------------------------------
-- Correct Letter Case
SELECT *
FROM [dbo].[Copy of PAN Number Validation Dataset]
WHERE pan_numbers <> UPPER(pan_numbers);


--------------------------------------------------
-- Cleaned PAN Numbers
SELECT DISTINCT
    UPPER(TRIM(pan_numbers)) AS pan_numbers
FROM [dbo].[Copy of PAN Number Validation Dataset]
WHERE pan_numbers IS NOT NULL
  AND pan_numbers <> '';


--------------------------------------------------
-- Function to check if adjacent characters are the same
CREATE FUNCTION dbo.fn_check_adjacent_characters (@p_str VARCHAR(100))
RETURNS BIT
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i < LEN(@p_str)
    BEGIN
        IF SUBSTRING(@p_str, @i, 1) = SUBSTRING(@p_str, @i + 1, 1)
            RETURN 1;  -- Adjacent characters found

        SET @i = @i + 1;
    END

    RETURN 0;  -- No adjacent characters
END;


-- Test adjacent character function
SELECT dbo.fn_check_adjacent_characters('ZZOVO');


--------------------------------------------------
-- Function to check if sequential characters are used
CREATE FUNCTION dbo.fn_check_Sequencial_characters (@p_str VARCHAR(100))
RETURNS BIT
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i < LEN(@p_str)
    BEGIN
        IF ASCII(SUBSTRING(@p_str, @i + 1, 1))
           - ASCII(SUBSTRING(@p_str, @i, 1)) <> 1
        BEGIN
            RETURN 0;  -- String does not form a sequence
        END

        SET @i = @i + 1;
    END

    RETURN 1;  -- Sequential
END;


-- Test sequential character function
SELECT dbo.fn_check_Sequencial_characters('AXCDE');


--------------------------------------------------
-- Validate PAN structure: AAAAA1234A
SELECT *
FROM [dbo].[Copy of PAN Number Validation Dataset]
WHERE pan_numbers LIKE
      '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][A-Z]';


--------------------------------------------------
-- Valid and Invalid PAN Categorization
CREATE VIEW vw_valid_invalid_pans
AS
WITH cte_cleaned_pan AS
(
    SELECT DISTINCT
        UPPER(TRIM(pan_numbers)) AS pan_numbers
    FROM [dbo].[Copy of PAN Number Validation Dataset]
    WHERE pan_numbers IS NOT NULL
      AND pan_numbers <> ''
),
cte_valid_pans AS
(
    SELECT *
    FROM cte_cleaned_pan
    WHERE dbo.fn_check_adjacent_characters(pan_numbers) = 0
      AND dbo.fn_check_Sequencial_characters(SUBSTRING(pan_numbers, 1, 5)) = 0
      AND dbo.fn_check_Sequencial_characters(SUBSTRING(pan_numbers, 6, 4)) = 0
      AND pan_numbers LIKE
          '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][A-Z]'
)
SELECT
    cln.pan_numbers,
    CASE
        WHEN vld.pan_numbers IS NOT NULL THEN 'Valid Pan'
        ELSE 'Inavlid Pan'
    END AS status
FROM cte_cleaned_pan cln
LEFT JOIN cte_valid_pans vld
       ON vld.pan_numbers = cln.pan_numbers;


--------------------------------------------------
-- View valid and invalid PANs
SELECT *
FROM vw_valid_invalid_pans;


--------------------------------------------------
-- Summary
WITH cte AS
(
    SELECT
        (SELECT COUNT(*)
         FROM [dbo].[Copy of PAN Number Validation Dataset]
        ) AS total_processed_records,
        SUM(CASE WHEN status = 'Valid Pan' THEN 1 ELSE 0 END) AS total_valid_pans,
        SUM(CASE WHEN status = 'Inavlid Pan' THEN 1 ELSE 0 END) AS total_invalid_pans
    FROM vw_valid_invalid_pans
)
SELECT
    total_processed_records,
    total_valid_pans,
    total_invalid_pans,
    (total_processed_records
     - (total_valid_pans + total_invalid_pans)) AS total_missing_pans
FROM cte;



