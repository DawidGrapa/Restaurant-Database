USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[WeeklyDiscountRaport]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[WeeklyDiscountRaport]
(	
	@StartDate date
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT        *
FROM           Discounts
WHERE        (DATEDIFF(day,  @StartDate, GrantedDate) BETWEEN 0 AND 7)
)
GO
