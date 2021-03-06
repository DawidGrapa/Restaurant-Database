USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddTableRestriction]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddTableRestriction]
    @TableID int,
    @validFrom date,
    @validTo date
	as
    BEGIN TRY
    IF NOT EXISTS(SELECT *
               FROM Tables
               WHERE TableID = @TableID)
           BEGIN
           RAISERROR('Such table does not',16,1)
           end
    IF EXISTS(SELECT *
               FROM TablesReservations TR
			   join TablesRestrictions on TR.TableID=TablesRestrictions.tableID
           join Reservations R on R.ReservationID = TR.ReservationID
           where TR.TableID = @TableID and ((validFrom < ReservationStartDate and validTo < ReservationEndDate) or 
           (validFrom > ReservationStartDate and validTo > ReservationEndDate) or 
           (validFrom > ReservationStartDate and validTo < ReservationEndDate))

)
           BEGIN
           RAISERROR('This table is reserved',16,1)
           end
    INSERT INTO TablesRestrictions(TableID,validFrom,validTo) VALUES
    (@TableID,@validFrom,@validTo)

    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when adding table restriction :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
