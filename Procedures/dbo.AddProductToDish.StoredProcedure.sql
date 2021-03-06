USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddProductToDish]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddProductToDish]
    @DishID int, 
    @ProductID int,
    @Quantity int
	as 
    BEGIN TRY
    IF NOT EXISTS(SELECT *
               FROM Menu
               WHERE DishID = @DishID)
           BEGIN
           RAISERROR('Such dish does not exist',16,1)
           end
    IF NOT EXISTS(SELECT *
               FROM Products
               WHERE ProductID = @ProductID)
           BEGIN
			RAISERROR('Such product does not exist',16,1)
           end
    INSERT INTO DishDetails(DishID,ProductID,Quantity) VALUES
    (@DishID,@ProductID,@Quantity)

    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when adding product to a dish :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
