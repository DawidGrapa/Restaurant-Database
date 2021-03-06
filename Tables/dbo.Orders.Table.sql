USE [u_grapa]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderPrice] [money] NULL,
	[OrderDate] [date] NOT NULL,
	[OutDate] [date] NULL,
	[PaidDate] [date] NULL,
	[RestaurantID] [int] NOT NULL,
	[DiscountValue] [real] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Restaurants]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders] CHECK  (([OrderPrice]>=(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders_1] CHECK  (([OutDate]>=[OrderDate]))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders_1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders_2] CHECK  (([PaidDate]>=[OrderDate] AND [PaidDate]<=[OutDate]))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders_2]
GO
