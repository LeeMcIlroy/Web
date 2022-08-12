USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_BOARD_COMMON_MORE_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


    exec GCRL_BOARD_COMMON_MORE_SEL
@pType='042',
@pRowNo=0,
@pReadSize=6

======================================================================*/
alter PROCEDURE [dbo].[GCRL_BOARD_COMMON_MORE_SEL]
(
    @pType      VARCHAR(3)  = '',

    @pDivCode1  VARCHAR(30) = '',
    @pDivCode2  VARCHAR(30) = '',
    @pKeyWord   NVARCHAR(30) = '',

    @pRowNo     INT         = 0,
    @pReadSize  INT         = 6

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT *
        FROM (
            SELECT  ROW_NUMBER() OVER(ORDER BY a.VIEW_ORDER ASC, a.IDX DESC) AS ROW_NO,
            
                    a.IDX,

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
                        ON  div1.GRP_CD = CASE @pType
                                            WHEN '013' THEN 'dept_div'
                                            WHEN '023' THEN 'year_div'
                                            WHEN '027' THEN 'year_div'
                                            WHEN '032' THEN 'faq_div'
                                            WHEN '042' THEN 'live_div'
                                            WHEN '043' THEN 'news_div'
                                            ELSE '' END
                        AND div1.COMM_CD = a.DIV_CODE1
                WHERE   a.[TYPE] = @pType
                    AND a.IDX > 0
                    AND a.VIEW_YN = 'Y'
                    AND a.TITLE LIKE '%' + @pKeyWord + '%'
                    AND a.CONTENT_F LIKE '%' + @pKeyWord + '%'
                    AND a.CONTENT_S LIKE '%' + @pKeyWord + '%'
                    AND a.DIV_CODE1 = CASE WHEN ISNULL(@pDivCode1, '') > ' ' THEN @pDivCode1 ELSE a.DIV_CODE1 END
                    AND a.DIV_CODE2 = CASE WHEN ISNULL(@pDivCode2, '') > ' ' THEN @pDivCode2 ELSE a.DIV_CODE2 END
                    AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)
        ) AS x
        WHERE x.ROW_NO BETWEEN (@pRowNo + 1) AND (@pRowNo + @pReadSize)
        ORDER BY ROW_NO ASC

END
SET NOCOUNT OFF;