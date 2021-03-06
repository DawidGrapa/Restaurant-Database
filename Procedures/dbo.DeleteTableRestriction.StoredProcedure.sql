USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[DeleteTableRestriction]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTableRestriction]
       @TableID int
AS
    BEGIN TRY
        IF NOT EXISTS(select * from TablesRestrictions where TableID = @TableID)
		BEGIN
			RAISERROR('This table does not exists.',16,1)
		END
		DELETE FROM TablesRestrictions where TableID = @TableID
    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error while deleting table restrictions :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
