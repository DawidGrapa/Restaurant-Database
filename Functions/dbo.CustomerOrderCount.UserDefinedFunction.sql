USE [u_grapa]
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOrderCount]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[CustomerOrderCount]
(	
	@CustomerID int
)
RETURNS Table
AS
RETURN 
(
SELECT count(*) as number from Orders where CustomerID=@CustomerID and (PaidDate is not null) 
)
GO
