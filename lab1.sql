--use everyloop3
select * from MoonMissions;
--1
SELECT 
    Spacecraft,
    [Launch date],
    [Carrier rocket],
    Operator,
    [Mission type]
INTO SuccessfulMissions
FROM MoonMissions;
GO
SELECT * FROM SuccessfulMissions;

--2 remove spaces from the colums
UPDATE SuccessfulMissions
SET Operator =LTRIM(RTRIM(Operator));
GO
--CHECK THE RESULT
SELECT oPERATOR
FROM SuccessfulMissions;


--3 (VG)   REMOVE ALTERNATIVE NAME FROM SPACECRAFT
UPDATE SuccessfulMissions
set Spacecraft=LTRIM(RTRIM(
    LEFT(SPACECRAFT,
    CASE
        WHEN CHARINDEX('(', SPACECRAFT) > 0 THEN CHARINDEX('(', SPACECRAFT) - 1
        ELSE LEN(SPACECRAFT)
    END)
))

GO
SELECT Spacecraft
FROM SuccessfulMissions;
-- FOR CHEKING IF ALL PARANTESE ARE REMOVED
SELECT Spacecraft
FROM SuccessfulMissions
WHERE Spacecraft LIKE '%(%' OR Spacecraft LIKE '%)%';

--4
--SEE ALL GROUPEND RESULTS
SELECT 
    Operator,
    [Mission type],
    COUNT(*) AS [Mission count]
FROM SuccessfulMissions
GROUP BY 
    Operator,
    [Mission type]
--FILTER
HAVING COUNT(*) > 1
ORDER BY 
    Operator,
    [Mission type];
GO

--5
SELECT * FROM Users;


-- IF I GET WRONG DATA I SHOULD DROP THE LAST TABLE fIRSTNAME+ ''+ LASTNAME DID NOT WORK
SELECT *,
       CONCAT(FirstName, ' ', LastName) AS Name,
       CASE 
            WHEN SUBSTRING(ID, LEN(ID)-1, 1) % 2 = 0 THEN 'Female'
            ELSE 'Male'
       END AS Gender
INTO NewUsers
FROM Users2;
GO
SELECT FirstName, LastName, Name
FROM NewUsers;

SELECT * FROM NewUsers
--6 SELECT ALL DUPLICATED USERNAME

SELECT USERNAME, COUNT(*) AS Count
FROM NewUsers
GROUP BY USERNAME
HAVING COUNT(*) > 1;



WITH Dups AS (
    SELECT 
        ID,
        UserName,
        ROW_NUMBER() OVER (PARTITION BY UserName ORDER BY ID) AS rn
    FROM NewUsers
)
UPDATE Dups
SET UserName = UserName + CAST(rn AS VARCHAR(10))
WHERE rn > 1;
GO


--7
WITH Dups AS (
    SELECT 
        ID,
        UserName,
        ROW_NUMBER() OVER (PARTITION BY UserName ORDER BY ID) AS rn
    FROM NewUsers
)
UPDATE Dups
SET UserName = UserName + CAST(rn AS VARCHAR(10))
WHERE rn > 1;
GO
SELECT UserName
FROM NewUsers
ORDER BY UserName;



--8
DELETE FROM NewUsers
WHERE Gender='Female' and LEFT(ID,4)<'1970'
-- CHECK ALL REMAINING WOMAN
SELECT *
FROM NewUsers
WHERE Gender = 'Female'
ORDER BY ID;


--9 to check the number of each character
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NewUsers';

INSERT INTO NewUsers (ID, UserName, Password, FirstName, LastName, Email, Phone, Name, Gender)

VALUES (
    '980512123456',      -- 12 characters
    'sara98',
    'password123',
    'Sara',
    'Johansson',
    'sara.j@example.com',
    '0701234567',
    'Sara Johansson',
    'Female'
);

select * from NewUsers
where UserName='sara98 '


GO

--10 (VG) Avrrage age of each gender
select
    Gender,
    AVG(
        case
            when (cast(LEFT(ID, 2) AS INT) < 30) 
            then year(getdate()) - (2000 + cast(LEFT(ID, 2) AS INT))
            else year(getdate()) - (1900 + cast(LEFT(ID, 2) AS INT))
        end
    )as AverageAge
from NewUsers
group by Gender


--11 select  all products from company.products
select * from company.products

select 
    company.products.Id,
    company.products.ProductName,
    company.categories.CategoryName,
    company.suppliers.CompanyName
    from company.products
    join company.suppliers
        on products.SupplierId = suppliers.Id
    join company.categories
        on products.CategoryId = categories.Id
    GO


    --12
    select * from company.regions
   select * from company.

SELECT 
    r.RegionDescription,
    COUNT(e.Id) AS NumberOfEmployees
FROM company.regions AS r
JOIN company.territories AS t
    ON r.Id = t.RegionId
JOIN company.employee_territory AS et
    ON t.Id = et.TerritoryId
JOIN company.employees AS e
    ON et.EmployeeId = e.Id
GROUP BY r.RegionDescription;
GO



--13 
