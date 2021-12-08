--Filter based on Date: Get all customers who enrolled after January 1st 2014.

SELECT EnrollmentDate FROM CustomerInfo WHERE EnrollmentDate > '20140101'

--Get all customers who enrolled in 2013.

SELECT EnrollmentDate FROM CustomerInfo WHERE Year(EnrollmentDate) = 2013

--Calculate the user's 1 year enrollment anniversary.

SELECT DATEADD(year, 1, EnrollmentDate) as AnniversaryDate FROM CustomerInfo

--How old was the customer when they enrolled.

SELECT Year(EnrollmentDate) - YearOfBirth as AgeAtEnrollment FROM CustomerInfo

--Alternate method using date math.

SELECT DATEDIFF(year, DATEFROMPARTS(YearOfBirth, 1, 1), EnrollmentDate) as AgeAtEnrollment FROM CustomerInfo

--String version of the month the customer enrolled.

SELECT DATENAME(month, YearOfBirth) FROM CustomerInfo