USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[MonthlyMenuRaport]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[MonthlyMenuRaport]
(	
	@StartDate date
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT        *
FROM           Menu
WHERE        (DATEDIFF(day,  @StartDate, ValidFrom) BETWEEN 0 AND 30)
)
GO
