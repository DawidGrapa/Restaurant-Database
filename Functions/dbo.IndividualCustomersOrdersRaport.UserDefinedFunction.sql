USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[IndividualCustomersOrdersRaport]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[IndividualCustomersOrdersRaport]
(	

)
RETURNS TABLE 
AS
RETURN 
(
	SELECT        OrderID,OrderPrice,OrderDate,DiscountValue
FROM           Orders
join Customers on orders.CustomerID=Customers.CustomerID
join CustomerIndividual on Customers.CustomerID=CustomerIndividual.CustomerID
)
GO
