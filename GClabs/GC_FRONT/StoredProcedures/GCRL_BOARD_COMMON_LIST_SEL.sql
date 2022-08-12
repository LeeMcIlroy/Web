USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_BOARD_COMMON_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        support/wording (025)의 경우 TITLE(약어) ASC 우선(ORDER시 DESC로 적용)
        support/announce (027)의 경우 DIV_CODE1(학술연도) DESC 우선(ORDER시 ASC로 적용)

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCRL_BOARD_COMMON_LIST_SEL]
(
    @pType      VARCHAR(3)  = '',

    @pDivCode1  VARCHAR(30) = '',
    @pDivCode2  VARCHAR(30) = '',

    @pKeyWord   NVARCHAR(30) = '',
    @pFL        VARCHAR(3)  = ''

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  ROW_NUMBER() OVER(ORDER BY
                                CASE a.[TYPE]
                                    WHEN '025' THEN a.TITLE
                                    ELSE '' END DESC,
                                CASE a.[TYPE]
                                    WHEN '027' THEN a.DIV_CODE1
                                    ELSE '' END ASC,
                                a.VIEW_ORDER DESC,
                                a.IDX ASC
                            ) AS ROW_NO,
    
            a.IDX,

            a.DIV_CODE1,
            ISNULL(div1.COMM_NM, '') AS DIV_NAME1,

            a.VIEW_CNT,
            a.VIEW_ORDER,
            a.NOTI_YN,

            a.TITLE,
            a.CONTENT_S,
            a.CONTENT_F,

            a.IMAGE1_ORG_NAME,
            a.IMAGE1_SAVE_NAME,

            a.IMAGE2_ORG_NAME,
            a.IMAGE2_SAVE_NAME,

            a.ATTACH1_ORG_NAME,
            a.ATTACH1_SAVE_NAME,

            a.ATTACH2_ORG_NAME,
            a.ATTACH2_SAVE_NAME,
            
            a.REGIST_DATE,

            CONVERT(BIT, CASE WHEN a.REGIST_DATE >= DATEADD(WEEK, -1, GETDATE()) THEN 1 ELSE 0 END) AS NEW_YN
        FROM dbo.BOARD_COMMON AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS div1
                ON  div1.GRP_CD = CASE a.[TYPE]
                                    WHEN '013' THEN 'dept_div'
                                    WHEN '032' THEN 'faq_div'
                                    WHEN '042' THEN 'live_div'
                                    WHEN '043' THEN 'news_div'
                                    WHEN '061' THEN 'updates_div_cd'
                                    WHEN '067' THEN 'materials_div'
                                    ELSE '' END
                AND div1.COMM_CD = a.DIV_CODE1
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.TITLE LIKE (CASE @pFL WHEN '123' THEN '[0-9]%' WHEN 'ETC' THEN '[^0-9a-Z]%' ELSE ISNULL(@pFL, '') + '%' END)

            AND (a.TITLE LIKE '%' + @pKeyWord + '%'
                OR a.CONTENT_F LIKE '%' + @pKeyWord + '%'
                OR a.CONTENT_S LIKE '%' + @pKeyWord + '%')
            AND a.DIV_CODE1 = CASE WHEN ISNULL(@pDivCode1, '') > ' ' THEN @pDivCode1 ELSE a.DIV_CODE1 END
            AND a.DIV_CODE2 = CASE WHEN ISNULL(@pDivCode2, '') > ' ' THEN @pDivCode2 ELSE a.DIV_CODE2 END
            AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)
        ORDER BY ROW_NO DESC

END
SET NOCOUNT OFF;