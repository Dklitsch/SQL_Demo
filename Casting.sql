--Simple cast.

SELECT CAST('1' AS INT)

--If cast is invalid the query fails.

SELECT CAST('INVALID' AS INT)

--You can use TRY_CAST to return null rather than failing the query.

SELECT TRY_CAST('INVALID' AS INT), TRY_CAST('1' AS INT)