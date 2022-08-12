USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_SUPPORT_CERTIFY_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        고객지원 / 인증현황

    ASSUMPTION

    EXAMPLE


    select * from BOARD_CERTIFY


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_SUPPORT_CERTIFY_LIST_SEL]
(
    @pType      VARCHAR(3)  = ''
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,
            a.CATEGORY_CODE,
            a.CERTIFY_NAME,
            a.PROGRAM_NAME,
            a.COUNTRY_NAME,
            a.ISSUER_NAME,
            a.ISSUE_DATE,
            a.CERTIFY_CONTENT,
            a.ANALYSIS_ITEM,
            a.IMAGE_ORG_NAME,
            a.IMAGE_SAVE_NAME,
            a.ATTACH_ORG_NAME,
            a.ATTACH_SAVE_NAME
        FROM dbo.BOARD_CERTIFY AS a
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)
        ORDER BY a.VIEW_ORDER ASC, a.IDX DESC


END
SET NOCOUNT OFF;