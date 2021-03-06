USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[AvailableTablesDate]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[AvailableTablesDate]
(	

	@RestaurantID int,
	@Places int,
	@StartDate datetime,
	@EndDate datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT TableID FROM Tables 
	WHERE Tables.RestaurantID = @RestaurantID 
	AND TableID NOT IN (
		Select TableID
		FROM TablesReservations
		JOIN Reservations on TablesReservations.ReservationID = Reservations.ReservationID
		WHERE @StartDate BETWEEN ReservationStartDate AND ReservationEndDate
		OR @EndDate BETWEEN ReservationStartDate AND ReservationEndDate
	)
	AND TableID NOT IN (
			SELECT TableID
			FROM TablesRestrictions
			WHERE
			@StartDate BETWEEN ValidFrom AND validTo
			OR @EndDate BETWEEN ValidFrom AND validTo
 )	AND PlaceLimit >= @Places


)
GO
