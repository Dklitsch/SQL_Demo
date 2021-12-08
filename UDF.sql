--Let's take a particularly ugly piece of aggregation code and turn it into a UDF.
--We wrote this statement earlier that calculate the IncomePerPerson in the household based on marital status.

--SELECT CASE MaritalStatus
--	WHEN 'Married' THEN Income / (ChildrenInHome + TeensInHome + 2)
--	WHEN 'Divorced' THEN Income / (ChildrenInHome + TeensInHome + 1)
--	WHEN 'Together' THEN Income / (ChildrenInHome + TeensInHome + 2)
--	WHEN 'Alone' THEN Income / (ChildrenInHome + TeensInHome + 1)
--	WHEN 'Widow' THEN Income / (ChildrenInHome + TeensInHome + 1)
--	WHEN 'Single' THEN Income / (ChildrenInHome + TeensInHome + 1)
--	END AS IncomePerPerson,
--	Income, ChildrenInHome, TeensInHome, MaritalStatus 
--	FROM CustomerInfo 
--	WHERE MaritalStatus NOT IN ('YOLO', 'Absurd');

IF OBJECT_ID('dbo.CalculateIncomePerPerson ') IS NOT NULL DROP FUNCTION dbo.CalculateIncomePerPerson ; 
GO

CREATE FUNCTION dbo.CalculateIncomePerPerson 
( 
  @MaritalStatus AS VARCHAR(20), 
  @Income AS MONEY,
  @OtherFamilyMembers AS INT
) 

RETURNS FLOAT 

AS 

BEGIN 
  RETURN 

	CASE @MaritalStatus
	WHEN 'Married' THEN @Income / (@OtherFamilyMembers + 2)
	WHEN 'Divorced' THEN @Income / (@OtherFamilyMembers + 1)
	WHEN 'Together' THEN @Income / (@OtherFamilyMembers + 2)
	WHEN 'Alone' THEN @Income / (@OtherFamilyMembers + 1)
	WHEN 'Widow' THEN @Income / (@OtherFamilyMembers + 1)
	WHEN 'Single' THEN @Income / (@OtherFamilyMembers + 1)
	--We're going to return null for our two nonsensical Marital Status categories.
	ELSE NULL

    END; 

END; 
GO

--The resulting query is much nicer to read.

SELECT dbo.CalculateIncomePerPerson(MaritalStatus, Income, ChildrenInHome + TeensInHome),
	Income, ChildrenInHome, TeensInHome, MaritalStatus 
	FROM CustomerInfo