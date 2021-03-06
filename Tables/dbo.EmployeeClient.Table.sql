USE [u_grapa]
GO
/****** Object:  Table [dbo].[EmployeeClient]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeClient](
	[EmployeeID] [int] NOT NULL,
	[ReservationID] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeClient] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeeClient]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeClient_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[EmployeeClient] CHECK CONSTRAINT [FK_EmployeeClient_Employees]
GO
ALTER TABLE [dbo].[EmployeeClient]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeClient_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[EmployeeClient] CHECK CONSTRAINT [FK_EmployeeClient_Reservations]
GO
