USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[CompanyCustomersOrdersRaport]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[CompanyCustomersOrdersRaport]
(	

)
RETURNS TABLE 
AS
RETURN 
(
	SELECT        OrderID,OrderPrice,OrderDate,DiscountValue
FROM           Orders
join Customers on orders.CustomerID=Customers.CustomerID
join CustomerCompany on Customers.CustomerID=CustomerCompany.CustomerID
)
GO
