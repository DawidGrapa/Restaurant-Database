USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[ChangeTableRestrictions]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangeTableRestrictions]
    @TableID int,
	@validFrom date,
	@validTo date
	as
    BEGIN TRY
    IF NOT EXISTS(SELECT *
               FROM TablesRestrictions
               WHERE TableID = @TableID)
           BEGIN
               RAISERROR ('This table does not exist',16,1)
           end
	IF EXISTS(SELECT *
               FROM TablesReservations as TR
			   join TablesRestrictions on TablesRestrictions.tableID = TR.tableID
           join Reservations R on R.ReservationID = TR.ReservationID
           where TR.TableID = @TableID and ((validFrom < ReservationStartDate and validTo < ReservationEndDate) or 
           (validFrom > ReservationStartDate and validTo > ReservationEndDate) or 
           (validFrom > ReservationStartDate and validTo < ReservationEndDate))

)
           BEGIN
			RAISERROR('This table is reserved',16,1)
           end
	
   UPDATE TablesRestrictions
				SET validFrom=@validFrom,
				validTo=@validTo
				Where TableID=@TableID

    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when changing a table restriction :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
