USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_AUTHMANAGER_AUTHDATA_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-08
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        관리자로그인 / 계정체크

    ASSUMPTION

    EXAMPLE

    execute GCMASTER_AUTHMANAGER_AUTHDATA_SEL @pIDX = '1'

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_AUTHMANAGER_AUTHDATA_SEL]
(
    @pIDX   INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  IDX,
            ADM_ID AS 'ID',
            ADM_NAME AS 'Name'
        FROM dbo.MEMBER_ADMIN
        WHERE IDX = @pIDX



    SELECT  a.IDX,

            b.GROUP_CODE AS 'Area',
            b.CONTROLLER AS 'Controller',
            b.[ACTION] AS 'Action',
            b.NAME AS 'MenuName'
        FROM dbo.COMMON_MENU_AUTH AS a
            INNER JOIN dbo.MEMBER_ADMIN AS adm
                ON  adm.AUTH_CODE = a.AUTH_CODE
                AND adm.IDX = @pIDX
            INNER JOIN dbo.COMMON_MENU AS b
                ON  b.IDX = a.IDX
                AND b.USE_YN = 'Y'
        WHERE   a.IDX > 0
            AND a.USE_YN = 1
        ORDER BY a.IDX ASC


END
SET NOCOUNT OFF;