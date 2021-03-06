USE [u_grapa]
GO
/****** Object:  Table [dbo].[TablesRestrictions]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablesRestrictions](
	[TableID] [int] NOT NULL,
	[validFrom] [date] NOT NULL,
	[validTo] [date] NULL,
 CONSTRAINT [PK_TablesRestrictions] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TablesRestrictions]  WITH NOCHECK ADD  CONSTRAINT [FK_TablesRestrictions_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[TablesRestrictions] CHECK CONSTRAINT [FK_TablesRestrictions_Tables]
GO
ALTER TABLE [dbo].[TablesRestrictions]  WITH CHECK ADD  CONSTRAINT [CK_TablesRestrictions] CHECK  (([ValidTo]>=[ValidFrom]))
GO
ALTER TABLE [dbo].[TablesRestrictions] CHECK CONSTRAINT [CK_TablesRestrictions]
GO
