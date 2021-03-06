USE [u_grapa]
GO
/****** Object:  StoredProcedure [dbo].[AddCustomerCompany]    Script Date: 17.03.2021 12:51:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddCustomerCompany]
       @CompanyName varchar(50),
    @NIP varchar(10),
      @Street varchar(30),
       @City varchar(30),
       @ZipCode varchar(10),
    @Phone varchar(20),
    @Email varchar(50)
AS
    BEGIN TRY
        INSERT INTO Customers(Phone,City,Street,ZipCode,Email)
        VALUES (@Phone,@City,@Street,@ZipCode,@Email)
		DECLARE @CustomerID int = (SELECT SCOPE_IDENTITY())
        INSERT INTO CustomerCompany(CustomerID,CompanyName,NIP)
        VALUES (@CustomerID,@CompanyName,@NIP)
    END TRY
       BEGIN CATCH
              DECLARE @errorMessage nvarchar(2048)
               SET @errorMessage = 'Error when adding company customer :'+CHAR(13) + ERROR_MESSAGE( ) ;
               THROW 52000, @errorMessage, 1;
      END CATCH
GO
