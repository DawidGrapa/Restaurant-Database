USE [u_grapa]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [varchar](20) NULL,
	[City] [varchar](30) NULL,
	[Street] [varchar](30) NULL,
	[ZipCode] [varchar](10) NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Customers] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Customers_1] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH NOCHECK ADD  CONSTRAINT [FK_Customers_CustomerCompany] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerCompany] ([CustomerID])
GO
ALTER TABLE [dbo].[Customers] NOCHECK CONSTRAINT [FK_Customers_CustomerCompany]
GO
ALTER TABLE [dbo].[Customers]  WITH NOCHECK ADD  CONSTRAINT [FK_Customers_CustomerIndividual] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerIndividual] ([CustomerID])
GO
ALTER TABLE [dbo].[Customers] NOCHECK CONSTRAINT [FK_Customers_CustomerIndividual]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CK_Customers] CHECK  ((isnumeric([Phone])=(1)))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CK_Customers_1] CHECK  (([ZipCode] like '[0-9][0-9]-[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers_1]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CK_Customers_2] CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers_2]
GO
