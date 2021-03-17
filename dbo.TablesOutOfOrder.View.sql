USE [u_grapa]
GO
/****** Object:  View [dbo].[TablesOutOfOrder]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TablesOutOfOrder] as 
	Select TableID from TablesRestrictions 
	where GETDATE()<=validTo and GETDATE()>=validFrom
GO
