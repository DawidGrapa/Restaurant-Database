USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDishProduct]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteDishProduct]
    @DishID int,
	@ProductID int
	as
    BEGIN TRY
    IF NOT EXISTS(SELECT *
               FROM DishDetails
               WHERE DishID = @DishID)
           BEGIN
               RAISERROR('This dish does not exist.',16,1)
           end
	IF NOT EXISTS(Select * from DishDetails where DishID=@DishID and ProductID=@ProductID)
		BEGIN
			RAISERROR('This product does not exist in this dish.',16,1)
		END
    DELETE FROM DishDetails where DishID = @DishID and ProductID=@ProductID

    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when deleting a dish product:'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
