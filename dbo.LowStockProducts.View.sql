USE [u_grapa]
GO
/****** Object:  View [dbo].[LowStockProducts]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LowStockProducts] as
Select productID,productName,UnitsInStock from Products where UnitsInStock<5
GO
