USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[SetOrderPaidDate]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetOrderPaidDate]
	@OrderID int,
	@PaidDate date
AS
 BEGIN TRY
    If not exists(Select * from Orders where OrderID=@OrderID)
	BEGIN
		RAISERROR('This order does not exist.',16,1)
	END
	UPDATE Orders
				SET PaidDate=@PaidDate
				Where OrderID=@OrderID
    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when changng paid date :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
