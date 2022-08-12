USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_EDITHISTORY_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-05
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자 수정이력

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_EDITHISTORY_SEL]
(
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN


    SELECT  ROW_NUMBER() OVER(ORDER BY a.REGIST_DATE, a.ITEM) AS ROW_NO,
            a.ITEM,
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE
        FROM dbo.MEMBER_ADMIN_EDIT_HISTORY AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
        WHERE   a.IDX = @pIDX
        ORDER BY ROW_NO DESC


END
SET NOCOUNT OFF;