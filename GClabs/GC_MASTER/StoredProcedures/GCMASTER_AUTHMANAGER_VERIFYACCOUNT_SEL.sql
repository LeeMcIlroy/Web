USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_AUTHMANAGER_VERIFYACCOUNT_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-08
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        관리자로그인 / 계정체크

    ASSUMPTION

    EXAMPLE

    

======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_AUTHMANAGER_VERIFYACCOUNT_SEL]
(
    @pLoginID   VARCHAR(20),
    @pPassword  VARCHAR(20),
    @pIpAddress VARCHAR(20)
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    DECLARE @iDX INT = 0;

    SELECT  @iDX = IDX
        FROM dbo.MEMBER_ADMIN
        WHERE IDX > 0
            AND ADM_ID = @pLoginID
            AND ADM_PWD = @pPassword
            AND USE_YN = 'Y'


    IF (@iDX > 0)
        BEGIN

            UPDATE  dbo.MEMBER_ADMIN
                SET ACCESS_DATE = GETDATE()
                WHERE IDX = @iDX


            INSERT
                INTO dbo.MEMBER_ADMIN_ACCESS_HISTORY
                VALUES
                    (@iDX, GETDATE(), @pIpAddress)
        END

    SELECT @iDX;

END
SET NOCOUNT OFF;