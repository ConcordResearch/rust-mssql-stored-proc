USE [SprocTest]
GO

CREATE PROCEDURE IncrementOne
AS
BEGIN
    UPDATE Incrementor
    SET Count = (SELECT Count from Incrementor WHERE Id = 1) + 1
    WHERE Id = 1
END;

GO