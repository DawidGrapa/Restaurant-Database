USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[CreateReservationForIndividualCustomer]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateReservationForIndividualCustomer]
	@RestaurantID int,
	@CustomerID int,
	@ReservationStartDate datetime,
	@ReservationEndDate datetime,
	@Places int,
	@Dishes DishTable READONLY
AS
BEGIN try
	IF @Places<2
	begin
		RAISERROR('Too low places.',16,1)
	end

	IF NOT EXISTS(Select * from AvailableTablesDate(@RestaurantID,@Places,@ReservationStartDate,@ReservationEndDate))
	begin
		RAISERROR('No free places.',16,1)
	end
	DECLARE @TableID int = (Select top 1 * from AvailableTablesDate(@RestaurantID,@Places,@ReservationStartDate,@ReservationEndDate))
	
	IF NOT EXISTS(Select * from Restaurants where RestaurantID=@RestaurantID)
	begin
		RAISERROR('This restaurant does not exist.',16,1)
	end
	IF NOT EXISTS(Select * from customers inner join CustomerIndividual 
	on Customers.CustomerID=CustomerIndividual.CustomerID 
	where customers.CustomerID = @CustomerID)
	begin
		RAISERROR('This customer does not exist or is not an individual customer.',16,1)
	end

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
		DECLARE @UnitPrice money = (SELECT DishPrice FROM MENU WHERE DishID = @DishID)
		set @Total = @Total + @UnitPrice * @Quantity;
	
	end
	DECLARE @NumberOfOrders int = (select * from CustomerOrderCount(@CustomerID))

	IF @NumberOfOrders < 5 and @Total < 200
	begin
		RAISERROR('You have to order for at least 200zł.',16,1)
	end

	IF @NumberOfOrders >=5 and @Total < 50
	begin
		RAISERROR('You have to order for at least 50zł.',16,1)
	end

	DECLARE @OrderID int 
	
	exec @OrderID =  AddOrderForIndividualCustomer @CustomerID=@CustomerID,@Dishes=@Dishes,@RestaurantID=@RestaurantID


	INSERT into Reservations(CustomerID,ReservationStartDate,OrderID,ReservationEndDate,RestaurantID)
	values (@CustomerID,@ReservationStartDate,@OrderID,@ReservationEndDate,@RestaurantID)

	DECLARE @ReservationID int = (Select SCOPE_IDENTITY())

	insert into TablesReservations(ReservationID,TableID) values (@ReservationID,@TableID)

END try
BEGIN CATCH
        DECLARE @errorMessage nvarchar(2048)
          SET @errorMessage = 'Error when adding reservation :'+CHAR(13) + ERROR_MESSAGE( ) ;
         THROW 52000, @errorMessage, 1;
END CATCH
GO
