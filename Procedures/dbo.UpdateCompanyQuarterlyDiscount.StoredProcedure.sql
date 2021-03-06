USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[UpdateCompanyQuarterlyDiscount]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCompanyQuarterlyDiscount]
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
	
    DECLARE @FK2 real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FK2');
    DECLARE @FR2 real = (SELECT Value FROM DiscountsValues WHERE RestaurantID = @RestaurantID AND [ID] = 'FR2');

    DECLARE @Total int = (SELECT Sum(OrderPrice) from orders where @RestaurantID=RestaurantID and @CustomerID=CustomerID
    and PaidDate is not null and DATEDIFF(day,orders.OrderDate,GETDATE()) between 0 and 90)

	IF @Total>=@FK2
	IF EXISTS(SELECT * FROm Discounts where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is not null )
	begin
		UPDATE Discounts set ValidUntil=DATEADD(day,90,GETDATE()) where CustomerID=@CustomerID and RestaurantID=@RestaurantID and ValidUntil is not null
	end
	ELSE
	begin
		INSERT INTO Discounts(CustomerID,RestaurantID,GrantedDate,ValidUntil,R) values (@CustomerID,@RestaurantID,GETDATE(),DATEADD(day,90,GETDATE()),@FR2)
	end
	END try 
 begin catch
       DECLARE @errorMessage nvarchar(2048)
       SET @errorMessage = 'Error when updating discount '+CHAR(13) + ERROR_MESSAGE( ) ;
       THROW 52000, @errorMessage, 1;
   end catch
GO
