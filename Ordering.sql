--Simple ordering, ascending by default.

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo ORDER BY YearOfBirth;

--To specify descending.

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo ORDER BY YearOfBirth DESC;

--We can use ordering and top to get the highest ranked in each column. For example the 5 most and least recent years in the YearOfBirthColumn.

SELECT DISTINCT TOP 5 YearOfBirth FROM CustomerInfo ORDER BY YearOfBirth;

SELECT DISTINCT TOP 5 YearOfBirth FROM CustomerInfo ORDER BY YearOfBirth DESC;

--When using top 5 like this we need to be careful about rows with tied values. The following query will always contain 3 individuals born in 1995, but they aren't guarenteed to be the same 3 individuals every time.

SELECT TOP 5 * FROM CustomerInfo ORDER BY YearOfBirth DESC;

--We can add tie-breakers to make this deterministic. The following query will always fetch the lowest Ids first.

SELECT TOP 5 * FROM CustomerInfo ORDER BY YearOfBirth DESC, Id;

--We can also use the with ties option if we're ok with fetching more rows.

SELECT TOP (5) WITH TIES * FROM CustomerInfo ORDER BY YearOfBirth DESC;

--The percent keyword can be used to get the top x% of qualifying rows. For example, the top 1% of income earners.

SELECT TOP 1 PERCENT Id, Income FROM CustomerInfo ORDER BY Income DESC;

--Offset-fetch can be used to get the 10th-20th highest income earners.

SELECT Id, Income FROM CustomerInfo ORDER BY Income DESC
	OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;