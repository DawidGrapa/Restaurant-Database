USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[CreateReservationForCompanyCustomer]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateReservationForCompanyCustomer]
	@RestaurantID int,
	@CustomerID int,
	@ReservationStartDate datetime,
	@ReservationEndDate datetime,
	@Places int,
	@Dishes DishTable READONLY,
	@EmployeeID int = NULL
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
	IF NOT EXISTS(Select * from customers inner join CustomerCompany
	on Customers.CustomerID=CustomerCompany.CustomerID 
	where customers.CustomerID = @CustomerID)
	begin
		RAISERROR('This customer does not exist or is not an company customer.',16,1)
	end

	
	DECLARE @OrderID int 
	
	exec @OrderID =  AddOrderForCompanyCustomer @CustomerID=@CustomerID,@Dishes=@Dishes,@RestaurantID=@RestaurantID


	INSERT into Reservations(CustomerID,ReservationStartDate,OrderID,ReservationEndDate,RestaurantID)
	values (@CustomerID,@ReservationStartDate,@OrderID,@ReservationEndDate,@RestaurantID)

	DECLARE @ReservationID int = (Select SCOPE_IDENTITY())

	IF @EmployeeID is not null
	begin
		IF NOT EXISTS(SELECT * from Employees where EmployeeID=@EmployeeID and CustomerID=@CustomerID)
			Begin
				RAISERROR('This employee does not exist.',16,1)
			end
		INSERT into EmployeeClient(EmployeeID,ReservationID) values (@EmployeeID,@ReservationID)
	end 




	insert into TablesReservations(ReservationID,TableID) values (@ReservationID,@TableID)

END try
BEGIN CATCH
        DECLARE @errorMessage nvarchar(2048)
          SET @errorMessage = 'Error when adding reservation :'+CHAR(13) + ERROR_MESSAGE( ) ;
         THROW 52000, @errorMessage, 1;
END CATCH
GO
