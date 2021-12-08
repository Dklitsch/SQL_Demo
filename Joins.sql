--We can join two tables together on shared values to combine their results.

SELECT * from CustomerInfo JOIN ProductsPurchased ON Id = CustomerId

--A query can contain multiple joins.

SELECT * from CustomerInfo CI
	JOIN ProductsPurchased PP ON Id = PP.CustomerId
	JOIN Promotions P ON Id = P.CustomerId

------
--Composite joins
-----

--Joins can contain multiple operators, this is called a composite join. Joins are also not limited to equality operators. Let's use this to simulate a where clause and fetch only the rows where the customer purchased more than 100 units of Wine.

SELECT * from CustomerInfo JOIN ProductsPurchased ON Id = CustomerId AND Wine > 100 ORDER BY Wine ASC

SELECT Count(*) from CustomerInfo JOIN ProductsPurchased ON Id = CustomerId

SELECT Count(*) from CustomerInfo JOIN ProductsPurchased ON Id = CustomerId AND Wine > 100

--Every row in CustomerInfo has a matching row in ProductsPurchased, let's use our composite join to create a fake table where the ids don't match up so nicely.

CREATE TABLE #TableWithMissingKeys
(Id int, Wine int);
GO 

Insert Into #TableWithMissingKeys
SELECT CustomerId, Wine from CustomerInfo JOIN ProductsPurchased ON Id = CustomerId AND Wine > 100 ORDER BY Wine ASC

------
--Outer joins
-----

--If we don't specify the kind of join, JOIN Clause does an INNER JOIN. We can specify other joins. 
--Let's use a left join to join our fake table with CustomerInfo but keep every row in Customer Info.
--We'll only see our Wine count if there's a corrusponding Id to join on, else the Wine column will be null.

SELECT * from CustomerInfo CI LEFT JOIN #TableWithMissingKeys MK ON CI.Id = MK.Id

--We can see our query returns the same number of rows as the original had.

SELECT Count(*) from CustomerInfo CI LEFT JOIN #TableWithMissingKeys MK ON CI.Id = MK.Id

SELECT Count(*) from CustomerInfo

--The only difference between a LEFT JOIN and a RIGHT JOIN is the ordering of the tables is which table retains all it's rows. We can reverse the ordering of the tables and use a RIGHT JOIN to get the same results.

SELECT * from #TableWithMissingKeys MK  RIGHT JOIN CustomerInfo CI ON MK.Id = CI.Id

DROP TABLE #TableWithMissingKeys