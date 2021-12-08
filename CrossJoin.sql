--Cross Joins are rarely useful but we can demo them. First let's make a temporary table to work with.

CREATE TABLE #CrossJoinDemo
(Number int);
GO 

--Using a simple while loop, we'll give the table some junk data to work with.

DECLARE @i AS INT = 1; 

WHILE @i <= 10 

BEGIN 

  INSERT INTO #CrossJoinDemo VALUES (@i)
  SET @i = @i + 1; 
END;

--This give us a tabele with 10 rows, numbered 1-10.
SELECT * from #CrossJoinDemo

--If we cross join #CrossJoinDemo with itself we get a table with 100 rows, with one row for every possible combination of the two tables.
SELECT * from #CrossJoinDemo CDJ1 CROSS JOIN #CrossJoinDemo CDJ2

SELECT Count(*) from #CrossJoinDemo CDJ1 CROSS JOIN #CrossJoinDemo CDJ2

DROP TABLE #CrossJoinDemo