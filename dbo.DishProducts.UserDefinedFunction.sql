USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[DishProducts]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DishProducts]
(	
	@DishID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT DishID,ProductID,Quantity from DishDetails where DishID=@DishID
)
GO
