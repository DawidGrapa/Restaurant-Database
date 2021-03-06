USE [u_grapa]
GO
/****** Object:  Table [dbo].[TablesReservations]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablesReservations](
	[ReservationID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
 CONSTRAINT [PK_TablesReservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC,
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TablesReservations]  WITH CHECK ADD  CONSTRAINT [FK_TablesReservations_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[TablesReservations] CHECK CONSTRAINT [FK_TablesReservations_Reservations]
GO
ALTER TABLE [dbo].[TablesReservations]  WITH CHECK ADD  CONSTRAINT [FK_TablesReservations_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[TablesReservations] CHECK CONSTRAINT [FK_TablesReservations_Tables]
GO
