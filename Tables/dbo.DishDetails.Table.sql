USE [u_grapa]
GO
/****** Object:  Table [dbo].[DishDetails]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DishDetails](
	[DishID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_DishDetails_1] PRIMARY KEY CLUSTERED 
(
	[DishID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DishDetails]  WITH CHECK ADD  CONSTRAINT [FK_DishDetails_Menu] FOREIGN KEY([DishID])
REFERENCES [dbo].[Menu] ([DishID])
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [FK_DishDetails_Menu]
GO
ALTER TABLE [dbo].[DishDetails]  WITH CHECK ADD  CONSTRAINT [FK_DishDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [FK_DishDetails_Products]
GO
ALTER TABLE [dbo].[DishDetails]  WITH CHECK ADD  CONSTRAINT [CK_DishDetails] CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [CK_DishDetails]
GO
