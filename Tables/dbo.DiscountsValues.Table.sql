USE [u_grapa]
GO
/****** Object:  Table [dbo].[DiscountsValues]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountsValues](
	[ID] [varchar](50) NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[Value] [float] NOT NULL,
 CONSTRAINT [PK_DiscountsValues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[RestaurantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DiscountsValues]  WITH CHECK ADD  CONSTRAINT [FK_DiscountsValues_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[DiscountsValues] CHECK CONSTRAINT [FK_DiscountsValues_Restaurants]
GO
