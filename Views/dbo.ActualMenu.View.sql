USE [u_grapa]
GO
/****** Object:  View [dbo].[ActualMenu]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ActualMenu] as
Select DishID, DishName from Menu
where GETDATE() between  ValidFrom and  ValidTo
GO
