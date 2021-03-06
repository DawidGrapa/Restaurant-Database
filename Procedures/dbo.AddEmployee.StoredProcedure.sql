USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddEmployee]
	@CustomerID int,
	@FirstName varchar(50),
	@LastName varchar(50)
AS
BEGIN try
	IF NOT EXISTS(Select * from CustomerCompany where CustomerID=@CustomerID)
	begin
		RAiSERROR('This customer does not exist.',16,1)
	end
	Insert into Employees(CustomerID,FirstName,LastName) values (@CustomerID,@FirstName,@LastName)
END try
begin catch
       DECLARE @errorMessage nvarchar(2048)
       SET @errorMessage = 'Error when adding employee '+CHAR(13) + ERROR_MESSAGE( ) ;
       THROW 52000, @errorMessage, 1;
   end catch
GO
