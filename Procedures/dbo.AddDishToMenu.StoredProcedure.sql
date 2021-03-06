USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddDishToMenu]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[AddDishToMenu]
	-- Add the parameters for the stored procedure here 
	@DishName varchar(30),
	@DishPrice money,
	@ValidFrom date = NULL,
	@ValidTo date = NULL,
	@RestaurantID int
AS
BEGIN TRY 
		
		IF NOT EXISTS(Select * from Restaurants where RestaurantID=@RestaurantID )
			BEGIN
				RAISERROR('This restaurant does not exist.',16,1)
			END
	INSERT INTO Menu(DishName,DishPrice,ValidFrom,ValidTo,RestaurantID)  VALUES (@DishName,@DishPrice,@ValidFrom,@ValidTo,@RestaurantID)
	 
END TRY
BEGIN CATCH 
	DECLARE @errorMessage nvarchar(2048) 
	SET @errorMessage = 'Error while adding Dish to Menu '+ERROR_MESSAGE();
	THROW 52000,@errorMessage,1;
END CATCH
GO
