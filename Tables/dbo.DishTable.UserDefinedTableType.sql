USE [u_grapa]
GO
/****** Object:  UserDefinedTableType [dbo].[DishTable]    Script Date: 17.03.2021 12:51:37 ******/
CREATE TYPE [dbo].[DishTable] AS TABLE(
	[DishID] [int] NULL,
	[Quantity] [int] NULL
)
GO
