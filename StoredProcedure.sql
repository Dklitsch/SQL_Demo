--Stored procedures are useful for creating reusable queries with complex arguments and logic. This query allows an external client to specify a variety of filters without having to write SQL.

IF OBJECT_ID('SPExample', 'P') IS NOT NULL 
  DROP PROC SPExample; 
GO 

 
CREATE PROC SPExample

--We want to allow the user to provide many ids to filter by. We'll allow them to pass the ids as a string and then split them in the query.
  @Ids AS VARCHAR(200) = '', 

  @fromdate AS DATETIME = '19000101', 

  @todate   AS DATETIME = '99991231', 

  @Education  AS VARCHAR(20) = ''

AS 


	BEGIN
		SELECT Id, EnrollmentDate, Education
			FROM CustomerInfo 
			WHERE EnrollmentDate >= @fromdate 
			  AND EnrollmentDate < @todate 
			  AND (@Education = Education OR @Education = '')
			  AND (Id in (Select value FROM STRING_SPLIT(@Ids, ',')) OR @Ids = '');

		--The OR predicates here allow the user to leave that parameter empty. We may get better performance from using IF ELSE, but we often face a trade off between readability and performance. Per best practices, I've avoided premature optimization.
	END

GO

--We can see our stored procedure works with no parameters at all, or any number of parameters we wish to enter.

EXEC SPExample;

EXEC SPExample @Ids = '1, 20, 25';

EXEC SPExample @fromdate = '20130101', @todate = '20140101'

EXEC SPExample @fromdate = '20130101', @todate = '20140101', @Education = 'Master'
