USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_BOARD_COMMON_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


    select * from BOARD_COMMON where idx = 31


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_BOARD_COMMON_VIEW_SEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    UPDATE  dbo.BOARD_COMMON
        SET VIEW_CNT = ISNULL(VIEW_CNT, 0) + 1
        WHERE   [TYPE] = @pType
            AND IDX = @pIDX


    DECLARE @tblBoardCommon  TABLE
    (
        ROW_NO  INT,
        IDX     INT,
        PRIMARY KEY (ROW_NO, IDX)
    )

    INSERT INTO @tblBoardCommon
    SELECT  ROW_NUMBER() OVER(ORDER BY a.VIEW_ORDER ASC, a.IDX DESC),
            a.IDX
        FROM dbo.BOARD_COMMON AS a
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)


    DECLARE @selectedRowNo INT;

    SELECT  @selectedRowNo = ROW_NO
        FROM @tblBoardCommon
        WHERE IDX = @pIDX


    SELECT  a.IDX,

            a.VIEW_CNT,
            a.VIEW_YN,
            a.VIEW_ORDER,
            a.VIEW_DATE,

            ISNULL(div1.COMM_NM, '') AS DIV_NAME1,

            a.TITLE,
            a.CONTENT_S,
            a.CONTENT_F,

            a.IMAGE1_ORG_NAME,
            a.IMAGE1_SAVE_NAME,
            a.IMAGE1_SIZE,

            a.ATTACH1_ORG_NAME,
            a.ATTACH1_SAVE_NAME,
            a.ATTACH1_SIZE,

            a.ATTACH2_ORG_NAME,
            a.ATTACH2_SAVE_NAME,
            a.ATTACH2_SIZE,

            a.LINK1_NAME,
            a.LINK1_URL,
            a.LINK2_NAME,
            a.LINK2_URL,
            a.LINK3_NAME,
            a.LINK3_URL,

            a.REGIST_DATE,

            ISNULL(p.IDX, 0) AS PREV_IDX,
            ISNULL(p.TITLE, '') AS PREV_TITLE,
            ISNULL(n.IDX, 0) AS NEXT_IDX,
            ISNULL(n.TITLE, '') AS NEXT_TITLE
        FROM dbo.BOARD_COMMON AS a
            INNER JOIN @tblBoardCommon AS b
                ON  b.IDX = a.IDX
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
            LEFT OUTER JOIN dbo.BOARD_COMMON AS p
                ON  p.[TYPE] = a.[TYPE]
                AND p.IDX = (SELECT IDX FROM @tblBoardCommon WHERE ROW_NO = @selectedRowNo - 1)
            LEFT OUTER JOIN dbo.BOARD_COMMON AS n
                ON  n.[TYPE] = a.[TYPE]
                AND n.IDX = (SELECT IDX FROM @tblBoardCommon WHERE ROW_NO = @selectedRowNo + 1)
        WHERE   a.[TYPE] = @pType
            AND a.IDX = @pIDX

END
SET NOCOUNT OFF;