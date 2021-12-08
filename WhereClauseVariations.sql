select * from CustomerInfo;

--Basic Where clause with equality.

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo WHERE Education = 'Graduation';

--Where clause with wildcard search.

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo WHERE Education like 'Gra%';

--Where clause with multiple selections on the same column.

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo WHERE Education in ('Graduation', 'Master');

--The Where clause use subquery as it's predicate. (Note: this is a contrived example, there are better ways to accomplish this query.)

SELECT YearOfBirth, Education, MaritalStatus FROM CustomerInfo WHERE Id in (SELECT CustomerId FROM ProductsPurchased WHERE Wine > 100);

--Using the between clausee to get all customers with incomes between $50,000 and $60,000

SELECT Id, Income FROM CustomerInfo WHERE Income BETWEEN 50000 AND 60000;

--Linking together logical operators for complex queries. For example, all customer who make more than $75,000 a year, or have a PhD and are married.

SELECT * FROM CustomerInfo WHERE (Income > 75000 OR Education = 'PhD') AND MaritalStatus = 'Married';

