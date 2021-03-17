USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddNewProductCategory]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[AddNewProductCategory] 
	-- Add the parameters for the stored procedure here
	@CategoryID int, 
	@CategoryName varchar(30) 
AS
BEGIN 
	INSERT INTO Categories(CategoryID,CategoryName) VALUES (@CategoryID,@CategoryName)
END 
GO
