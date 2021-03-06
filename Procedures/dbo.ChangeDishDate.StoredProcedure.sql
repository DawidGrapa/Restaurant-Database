USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[ChangeDishDate]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangeDishDate]
		@DishName varchar(30),
       @ValidFrom date,
    @ValidTo date
      
AS
    BEGIN TRY
        IF NOT EXISTS(SELECT * from MENU where DishName = @DishName)
			BEGIN
				RAISERROR('This Dish does not exist.',16,1)
			END
			UPDATE Menu
				SET ValidFrom=@ValidFrom,
				ValidTo=@ValidTo
				Where DishName=@DishName
    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when changing dish date  :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
