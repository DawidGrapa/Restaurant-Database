USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateMonthlyInvoice]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GenerateMonthlyInvoice]
(	
	@CustomerID int,
	@RestaurantID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT OrderID,customers.CustomerID,OrderPrice,OrderDate,restaurants.RestaurantID,RestaurantName,NIP,customers.City,customers.street,customers.ZipCode,email,Phone
	from orders inner join Restaurants on Restaurants.RestaurantID=Orders.RestaurantID join Customers on Customers.customerID=Orders.CustomerID
	join CustomerCompany on CustomerCompany.customerID=Customers.CustomerID where Orders.CustomerID=@CustomerID and orders.RestaurantID=@RestaurantID and DATEDIFF(day,OrderDate,GETDATE()) between 0 and 30

)
GO
