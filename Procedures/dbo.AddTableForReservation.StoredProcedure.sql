USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddTableForReservation]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddTableForReservation]
	@ReservationID int,
	@Places int,
	@RestaurantID int
AS
BEGIN try
	IF NOT EXISTS(SELECT * FROM Reservations WHERE ReservationID=@ReservationID)
	BEGIN
		raiserrOR('This reservation does not exist.',16,1)
	END
	IF NOT EXISTS(SELECT * FROM Restaurants WHERE RestaurantID=@RestaurantID)
	BEGIN 
		raiserrOR('This restaurant does not exist.',16,1)
	END
	DECLARE @ReservationStartDate datetime = (select ReservationStartDate from Reservations where ReservationID = @ReservationID)
	DECLARE @ReservationEndDate datetime = (select ReservationEndDate from Reservations where ReservationID = @ReservationID)
	IF NOT EXISTS(Select * from AvailableTablesDate(@RestaurantID,@Places,@ReservationStartDate,@ReservationEndDate))
	begin
		RAISERROR('No free places.',16,1)
	end
	DECLARE @TableID int = (Select top 1 * from AvailableTablesDate(@RestaurantID,@Places,@ReservationStartDate,@ReservationEndDate))
	Insert into TablesReservations(ReservationID,TableID) values (@ReservationID,@TableID)
END try
 begin catch
       DECLARE @errorMessage nvarchar(2048)
       SET @errorMessage = 'Error when adding table '+CHAR(13) + ERROR_MESSAGE( ) ;
       THROW 52000, @errorMessage, 1;
   end catch
GO
