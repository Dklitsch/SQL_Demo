--Simple aggregation. Average income grouped by education level, with a simple alias for the average.

SELECT Education, AVG(Income) FROM CustomerInfo as AverageIncome GROUP BY Education;

--Multiple aggregations can be done in a single query. We'll add the sum total of children for each education level.

SELECT Education, AVG(Income) as AverageIncome, SUM(ChildrenInHome) as TotalChildren FROM CustomerInfo GROUP BY Education;

--The Where claus is always calculated before the aggregation. We can use this to aggregate only customers born after 1975.

SELECT Education, AVG(Income) as AverageIncome, SUM(ChildrenInHome) as TotalChildren, Min(YearOfBirth) as EarliestYearInQuery
	FROM CustomerInfo 
	WHERE YearOfBirth >= 1975
	GROUP BY Education;

--Because the Where claus is applied before aggregations are calculated, if we want to filter using the aggregations, we have to use the Having claus. In this case we'll filtered out the education levels with average income of less than $50,000 per year.

SELECT Education, AVG(Income) as AverageIncome 
	FROM CustomerInfo 
	GROUP BY Education
	HAVING AVG(Income) > 50000;

--Window clauses are very powerful but can seem very complicated. The following query ranks every customer by their income divided by education level. So the customer with rank 1 and PhD Education is the highest earner with a PhD, where the customer with rank 1 and Master level Education is the highest earner with a master's degree.

SELECT Id, Income, Education, 
	ROW_NUMBER() OVER(PARTITION BY Education ORDER BY Income DESC) AS IncomeRank 
	FROM CustomerInfo
	ORDER BY Income DESC;

--Window clauses can be used to put multiple aggregations in the same query. Let's do a query with a row that calculates the average income for everyone with that Educational attainment and an average income for everyone with that marital status, as well as the overall average income for everyone.

SELECT Id, Income, Education, MaritalStatus,
	AVG(Income) OVER(PARTITION BY Education ORDER BY Income DESC) AS AverageIncomeForEducation,
	AVG(Income) OVER(PARTITION BY MaritalStatus ORDER BY Income DESC) AS AverageIncomeForMaritalStatus,
	AVG(Income) OVER() AS AverageIncome
	FROM CustomerInfo;

--

--Using Grouping Sets to easily get the average income broken down by both education level and the number of children in the home, as well as the average income for that education level, the average income broken down by number of children, and the overall average income.

SELECT AVG(Income), Education, ChildrenInHome AS AverageIncome
	FROM CustomerInfo
	GROUP BY
		GROUPING SETS(
		(Education, ChildrenInHome),
		(Education),
		(ChildrenInHome),
		()
		);

--We can use cube to do the same thing in a more compact syntax.

SELECT AVG(Income), Education, ChildrenInHome AS AverageIncome
	FROM CustomerInfo
	GROUP BY CUBE (Education, ChildrenInHome);

--Simple math, for example the income split between every individual in the household for married households.

SELECT Income / (ChildrenInHome + TeensInHome + 2) as IncomePerPerson, Income, ChildrenInHome, TeensInHome, MaritalStatus FROM CustomerInfo WHERE MaritalStatus = 'Married' ;

--Our IncomePerPerson field is going to need different values dependening on whether the household is a single person or a married couple. Let's use the CASE statement to calculate that.

SELECT CASE MaritalStatus
	WHEN 'Married' THEN Income / (ChildrenInHome + TeensInHome + 2)
	WHEN 'Divorced' THEN Income / (ChildrenInHome + TeensInHome + 1)
	WHEN 'Together' THEN Income / (ChildrenInHome + TeensInHome + 2)
	WHEN 'Alone' THEN Income / (ChildrenInHome + TeensInHome + 1)
	WHEN 'Widow' THEN Income / (ChildrenInHome + TeensInHome + 1)
	WHEN 'Single' THEN Income / (ChildrenInHome + TeensInHome + 1)
	END AS IncomePerPerson,
	Income, ChildrenInHome, TeensInHome, MaritalStatus 
	FROM CustomerInfo 
	WHERE MaritalStatus NOT IN ('YOLO', 'Absurd');

--Check out UDF.sql where we use a UDF to make this CASE statement a lot more readable!