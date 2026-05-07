SELECT firstname FROM users;
SELECT len(firstname)  as 'length' ,firstname FROM users; --the function LEN() calculates how many characters are in each firstname.
SELECT len(firstname), DATALENGTH(firstname), firstname FROM users; -- calculates how many bytes are in each firstname.
SELECT IDENTITY(int, 1,1)as Ident,*into users2 from users; -- creates a new table users2 with an identity column and copies all data from users into it.
SELECT * FROM users2; -- displays all records from the new table users2.


SELECT GETDATE();
SELECT GETUTCDATE();-- GETDATE() returns the current date and time of the server's local time zone, while GETUTCDATE() returns the current date and time in Coordinated Universal Time (UTC).
SELECT SYSDATETIME(); -- returns the current date and time with more precision than GETDATE
SELECT DATEADD(year,3, DATEADD(hour,2, GETDATE())); -- adds 3 years and 2 hours to the current date and time.
Select DATEDIFF(year, '2000-01-01', GETDATE()) as 'Years since 2000'; -- calculates the number of years between January 1, 2000 and the current date.


SELECT isdate('2024-06-01 15:53:97'); -- checks if the string '2024-06-01 15:53:97' is a valid date format.



SELECT abs(-5), sin(1), cos(1+2*PI()), sqrt(16), round(3.14159, 2); -- demonstrates various mathematical functions: absolute value, sine, c
SELECT choose(3,'röd','grön','blå'); -- returns 'röd' because the index 1 corresponds to the first argument after the index.
SELECT iif(1=1, 'sant','falsk') ;

--count(*) counts the total number of rows in the table, while count(column_name) counts the number of non-null values in that specific column.
SELECT
     COUNT(*) AS 'Antal rader',
     COUNT(Meltingpoint) AS 'Antal värden i Meltingpoint',
     COUNT(Boilingpoint) AS 'Antal värden i Boilingpoint',
     COUNT(*) - COUNT(Meltingpoint) AS 'Antal nullvärden i Meltingpoint',
     COUNT(*) - COUNT(Boilingpoint) AS 'Antal nullvärden i Boilingpoint'
FROM Elements
WHERE Number <= 20;


SELECT
    [Group],
    SUM(Mass) AS TotalMass,
    MIN(Meltingpoint) AS MinMeltingpoint,
    MAX(Meltingpoint) AS MaxMeltingpoint,
    AVG(Meltingpoint) AS AvgMeltingpoint,
    COUNT(Meltingpoint) AS CountMeltingpoint,
    STRING_AGG(Symbol, ', ') AS Symbols

FROM Elements
GROUP BY [Group];


SELECT * from company.orders where orderdate >= '2013-01-01' order by ShipCountry; -- retrieves all orders from the company.orders table that were placed in January 2024.




