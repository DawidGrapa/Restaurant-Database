USE [u_grapa]
GO
/****** Object:  View [dbo].[DishOrdersCount]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DishOrdersCount] as
Select Menu.DishID, Menu.DishName, sum(Quantity) as OrdersCount
from [Order Details] as OD
join Menu on Menu.DishID = OD.DishID
GROUP BY Menu.DishId, Menu.DishName 
ORDER BY OrdersCount desc OFFSET 0 ROWS
GO
