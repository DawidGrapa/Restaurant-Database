USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[UpdateCompanyMonthlyDiscount]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCompanyMonthlyDiscount]
	@CustomerID int,
	@RestaurantID int
AS
BEGIN try
	IF NOT EXISTS(Select * from CustomerCompany where CustomerID=@CustomerID)
	begin
		RAISERROR('This customer does not exist.',16,1)
	end
	IF NOT EXISTS(Select * from Restaurants where RestaurantID=@RestaurantID)
	begin
		RAISERROR('This restaurant does not exist.',16,1)
	end

	DECLARE @FZ real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FZ');
	DECLARE @FK1 real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FK1');
	DECLARE @FR1 real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FR1');
	DECLARE @FM real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FM');
	
	DECLARE @OrdersCount int = (SELECT COUNT(*) from orders where @RestaurantID=RestaurantID and @CustomerID=CustomerID
	and PaidDate is not null and DATEDIFF(day,orders.OrderDate,GETDATE()) between 0 and 30)
	DECLARE @Total int = (SELECT Sum(OrderPrice) from orders where @RestaurantID=RestaurantID and @CustomerID=CustomerID
	and PaidDate is not null and DATEDIFF(day,orders.OrderDate,GETDATE()) between 0 and 30)

	IF @OrdersCount>=@FZ and @Total >=@FK1
	begin
	IF EXISTS(SELECT * FROm Discounts where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is null )
	begin
		UPDATE Discounts set R=R+@FR1, GrantedDate=GETDATE() where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is null
	end
	ELSE
	begin
		INSERT into Discounts(CustomerID,GrantedDate,RestaurantID,R) values (@CustomerID,GETDATE(),@RestaurantID,@FR1)
	end
	end
	ELSE
	begin
		IF EXISTS(SELECT * FROm Discounts where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is null)
	begin
		UPDATE Discounts set R=0, GrantedDate=GETDATE()  where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is null
	end
	end




END try
begin catch
       DECLARE @errorMessage nvarchar(2048)
       SET @errorMessage = 'Error when updating discount '+CHAR(13) + ERROR_MESSAGE( ) ;
       THROW 52000, @errorMessage, 1;
   end catch
GO
