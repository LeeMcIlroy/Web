USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_MAIN_SEARCH_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        support/wording (025)의 경우 TITLE(약어) ASC 우선(ORDER시 DESC로 적용)
        support/announce (027)의 경우 DIV_CODE1(학술연도) DESC 우선(ORDER시 ASC로 적용)

    ASSUMPTION

    EXAMPLE


    select * from ALLERGEN
    select * from PANEL


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_MAIN_SEARCH_LIST_SEL]
(
    @pKeyWord   NVARCHAR(30) = ''
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN


    SELECT  '007' AS [TYPE],
            0 AS ROW_NO,
            0 AS IDX,
            ARG_NM AS TITLE
        FROM dbo.ALLERGEN AS a
        WHERE   a.ARG_CD > ' '
            AND a.ARG_NM LIKE '%' + @pKeyWord + '%'
            AND a.VIEW_YN = 'Y'

    UNION ALL

    SELECT  CASE WHEN a.PAN_TYP = '02' THEN '009' ELSE '008' END AS [TYPE],
            0 AS ROW_NO,
            0 AS IDX,
            PAN_NM AS TITLE
        FROM dbo.PANEL AS a
        WHERE   a.PAN_TYP > ' '
            AND a.PAN_NM LIKE '%' + @pKeyWord + '%'
            AND a.VIEW_YN = 'Y'

    UNION ALL

    SELECT  a.[TYPE],
            ROW_NUMBER() OVER(PARTITION BY
                                a.[TYPE]
                                ORDER BY
                                a.VIEW_ORDER ASC,
                                a.IDX DESC
                            ) AS ROW_NO,
            a.IDX,
            a.TITLE
        FROM dbo.BOARD_COMMON AS a
        WHERE   a.[TYPE] BETWEEN '011' AND '060'
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND (a.TITLE LIKE '%' + @pKeyWord + '%'
                OR a.CONTENT_F LIKE '%' + @pKeyWord + '%'
                OR a.CONTENT_S LIKE '%' + @pKeyWord + '%')
            AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)

    UNION ALL

    SELECT  a.[TYPE],
            0 AS ROW_NO,
            a.IDX,
            a.NAME AS TITLE
        FROM dbo.BOARD_DOCTORS AS a
        WHERE   a.[TYPE] = '051'
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND (a.NAME LIKE '%' + @pKeyWord + '%'
                OR a.SUMMARY LIKE '%' + @pKeyWord + '%')

    UNION ALL

    SELECT  '052' AS [TYPE],
            0 AS ROW_NO,
            a.IDX,
            a.BRANCH_NAME AS TITLE
        FROM dbo.BOARD_NETWORK AS a
        WHERE   a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.BRANCH_NAME LIKE '%' + @pKeyWord + '%'

        ORDER BY [TYPE], ROW_NO

    

END
SET NOCOUNT OFF;