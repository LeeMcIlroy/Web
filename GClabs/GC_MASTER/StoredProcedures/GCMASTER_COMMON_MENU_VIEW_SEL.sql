USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_MENU_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-05-20
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 메뉴관리

    ASSUMPTION

    EXAMPLE
    
    select * from MEMBER_ADMIN


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_COMMON_MENU_VIEW_SEL]
(
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,
            a.GROUP_CODE,
            a.CONTROLLER,
            a.[ACTION],
            a.NAME,
            a.USE_YN,

            registor.ADM_NAME AS REGIST_NAME,
            registor.ADM_ID AS REGIST_ID,
            a.REGIST_DATE,
            updator.ADM_NAME AS UPDATE_NAME,
            updator.ADM_ID AS UPDATE_ID,
            a.UPDATE_DATE
        FROM dbo.COMMON_MENU AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updator
                ON  updator.IDX = a.UPDATE_IDX
        WHERE   a.IDX = @pIDX


END
SET NOCOUNT OFF;