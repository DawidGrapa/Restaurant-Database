USE [u_grapa]
GO
/****** Object:  View [dbo].[ReservationsFromLastWeek]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReservationsFromLastWeek] as 
SELECT * 
FROM Reservations
WHERE DATEDIFF(day,ReservationStartDate,GETDATE()) between 0 and 7
GO
