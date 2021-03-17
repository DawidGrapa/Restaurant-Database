USE [u_grapa]
GO
/****** Object:  View [dbo].[DishesFromLastWeek]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DishesFromLastWeek] as 
SELECT * 
FROM MENU
WHERE DATEDIFF(day,ValidFrom,GETDATE()) between 0 and 7
GO
