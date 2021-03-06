USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCurrentDiscount]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GetCurrentDiscount]
(	
	@CustomerID int,
	@RestaurantID int
)
RETURNS REAL 
AS
Begin
	IF EXISTS(select * from CustomerIndividual where @CustomerID=CustomerID)
	Begin
		DECLARE @R real = (Select SUM(R) from Discounts where CustomerID=@CustomerID and ((GETDATE() between GrantedDate and ValidUntil) or (ValidUntil is null)))
		IF @R is not null
		return @R
	end
	IF EXISTS(Select * from CustomerCompany where CustomerID=@CustomerID)
	begin
		DECLARE @RC real = (select SUM(R) from Discounts where CustomerID=@CustomerID and ((GETDATE() between GrantedDate and ValidUntil) or (ValidUntil is null)))
		IF @RC is not null
		return @RC
	end
	return 0
end
GO
