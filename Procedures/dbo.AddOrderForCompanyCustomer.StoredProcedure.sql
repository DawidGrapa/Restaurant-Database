USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddOrderForCompanyCustomer]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddOrderForCompanyCustomer]
	-- Add the parameters for the stored procedure here
	@CustomerID int,
	@Dishes DishTable READONLY,
	@RestaurantID int
	AS
BEGIN TRY
	IF NOT EXISTS(SELECT * from Customers inner join CustomerCompany 
	as ci on ci.CustomerID = Customers.CustomerID where customers.customerID = @CustomerID)
	BEGIN
		RAISERROR('This customer does not exist or is not an company customer.',16,1)
	END
	IF NOT EXISTS(Select * from Restaurants where @RestaurantID=RestaurantID)
	begin
		RAISERROR('This restaurant does not exist.',16,1)
	end
	INSERT INTO Orders(CustomerID,RestaurantID,OrderDate) values (@CustomerID,@RestaurantID,GETDATE())
	DECLARE @OrderID int = (SELECT SCOPE_IDENTITY())
	DECLARE @DishesCount int = (SELECT COUNT(DishID) FROM @Dishes)
	DECLARE @Curr int = 0
	DECLARE @Total money = 0
	WHILE @Curr < @DishesCount
	begin
		set @curr = @curr + 1
		DECLARE @DishID int = (
			SELECT InnerSelect.DishID
			FROM (
				SELECT
					DishID,
				ROW_NUMBER() OVER (ORDER BY DishID) AS RowNumber
					FROM @Dishes) AS InnerSelect
						WHERE InnerSelect.RowNumber = @Curr)
		DECLARE @Quantity int = (SELECT Quantity FROM @Dishes WHERE DishID = @DishID)
		DECLARE @UnitPrice money = (SELECT DishPrice FROM Menu WHERE DishID = @DishID)
		set @Total = @Total + @UnitPrice * @Quantity;
		INSERT INTO [Order Details](OrderID, DishID, Quantity) VALUES (@OrderID,@DishID,@Quantity)
		SET @Total = @Total*(1-(SELECT dbo.GetCurrentDiscount( @CustomerID,@RestaurantID ) as R)/100)
		Update Orders set OrderPrice = @Total,DiscountValue = (SELECT dbo.GetCurrentDiscount( @CustomerID,@RestaurantID ) as R) where OrderID=@OrderID
	end
	RETURN @ORDERID
END TRY
 BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when adding order :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
END CATCH
GO
