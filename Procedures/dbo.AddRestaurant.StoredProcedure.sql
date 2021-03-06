USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddRestaurant]
       @RestaurantName varchar(50),
       @ZipCode varchar(10),
      @Street varchar(50),
       @City varchar(50)
       
AS
    BEGIN TRY
        INSERT INTO Restaurants(RestaurantName,ZipCode,City,Street)
        VALUES (@RestaurantName,@ZipCode,@City,@Street)
    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when adding Restaurant :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
