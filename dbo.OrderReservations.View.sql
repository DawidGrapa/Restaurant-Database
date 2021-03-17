USE [u_grapa]
GO
/****** Object:  View [dbo].[OrderReservations]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[OrderReservations] as 
Select ReservationID, ReservationStartDate,ReservationEndDate,orders.OrderID,orders.PaidDate from Reservations 
inner join Orders on orders.OrderID=Reservations.OrderID
GO
