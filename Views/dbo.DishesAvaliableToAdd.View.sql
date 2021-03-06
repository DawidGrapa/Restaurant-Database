USE [u_grapa]
GO
/****** Object:  View [dbo].[DishesAvaliableToAdd]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DishesAvaliableToAdd] as
select dishID,DishName,DATEDIFF(day,ValidTo,GETDATE()) as DaysNotInMenu from menu where DATEDIFF(day,ValidTo,GETDATE()) between 0 and 30 or ValidTo is null order by 3 desc OFFSET 0 ROWS
GO
