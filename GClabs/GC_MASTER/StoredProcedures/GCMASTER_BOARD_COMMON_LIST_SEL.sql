USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_BOARD_COMMON_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 게시판 / 공통

    ASSUMPTION

    EXAMPLE

    execute GCMASTER_BOARD_COMMON_LIST_SEL
    @pType='072',
    @pDateType='1',
    @pDatePick1='2000-01-01',
    @pDatePick2='2999-12-31',
    @pDatePeriod='A',
    @pViewYN='A',
    @pNotiYN='A',
    @pDivCode1='',
    @pKeyType='',
    @pKeyWord='TQ'



======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_BOARD_COMMON_LIST_SEL]
(
    @pType          VARCHAR(3)  = '',
    @pDateType      VARCHAR(1)  = '1',  -- 1:REGIST, 2:UPDATE
    @pDatePick1     VARCHAR(10) = '2000-01-01',
    @pDatePick2     VARCHAR(10) = '2999-12-31',
    @pDatePeriod    CHAR(1)     = 'A',  -- A:All, Y:Year, Q:Quarter, M:Month
    @pViewYN        CHAR(1)     = 'A',  -- A:All, Y, N
    @pNotiYN        CHAR(1)     = 'A',  -- A:All, Y, N
    @pDivCode1      VARCHAR(3)  = '',   -- 
    @pKeyType       VARCHAR(1)  = '',   -- 
    @pKeyWord       NVARCHAR(30) = ''

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    DECLARE @vRegistDate1 DATETIME, @vRegistDate2 DATETIME,
            @vUpdateDate1 DATETIME, @vUpdateDate2 DATETIME
            ;


    IF (ISNULL(@pDatePeriod, '') = 'A')
        BEGIN
            SET @vRegistDate1 = '2000-01-01';
            SET @vRegistDate2 = '2999-12-31 23:59:59';
            SET @vUpdateDate1 = '2000-01-01';
            SET @vUpdateDate2 = '2999-12-31 23:59:59';
        END
    ELSE IF (@pDateType = '2')
        BEGIN
            SET @vRegistDate1 = '2000-01-01';
            SET @vRegistDate2 = '2999-12-31 23:59:59';
            SET @vUpdateDate1 = @pDatePick1;
            SET @vUpdateDate2 = @pDatePick2 + ' 23:59:59';
        END
    ELSE IF (@pDateType = '1')
        BEGIN
            SET @vRegistDate1 = @pDatePick1;
            SET @vRegistDate2 = @pDatePick2 + ' 23:59:59';
            SET @vUpdateDate1 = '2000-01-01';
            SET @vUpdateDate2 = '2999-12-31 23:59:59';
        END


    SELECT  a.IDX,
            a.DIV_CODE1,
            a.DIV_CODE2,
            ISNULL(div1.COMM_NM, '') AS DIV_NAME1,
            ISNULL(div2.COMM_NM, '') AS DIV_NAME2,
            CONVERT(VARCHAR(10), ISNULL(a.DIV_DATE1, GETDATE()), 120) AS DIV_DATE1,
            a.IMAGE1_SAVE_NAME,
            a.TITLE,
            a.CONTENT_S,
            a.CONTENT_F,
            a.VIEW_CNT,
            a.VIEW_YN,
            a.VIEW_ORDER,
            a.NOTI_YN,
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,
            a.UPDATE_DATE
        FROM dbo.BOARD_COMMON AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS div1
                ON  div1.GRP_CD = CASE @pType
                                    WHEN '013' THEN 'dept_div'
                                    WHEN '032' THEN 'faq_div'
                                    WHEN '042' THEN 'live_div'
                                    WHEN '043' THEN 'news_div'
                                    WHEN '061' THEN 'updates_div_cd'
                                    WHEN '067' THEN 'materials_div'
                                    WHEN '072' THEN 'dept_div_en'
                                    ELSE '' END
                AND div1.COMM_CD = a.DIV_CODE1
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS div2
                ON  div2.GRP_CD = CASE @pType
                                    WHEN '023' THEN ''
                                    ELSE '' END
                AND div2.COMM_CD = a.DIV_CODE2
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = CASE WHEN @pViewYN = 'A' THEN a.VIEW_YN ELSE @pViewYN END
            AND a.NOTI_YN = CASE WHEN @pNotiYN = 'A' THEN a.NOTI_YN ELSE @pNotiYN END
            AND a.DIV_CODE1 = CASE WHEN ISNULL(@pDivCode1, '') = '' THEN a.DIV_CODE1 ELSE @pDivCode1 END

            AND (CASE   WHEN @pKeyType = '' AND ISNULL(@pKeyWord, '') > '' THEN a.TITLE + ' ' + a.CONTENT_F + ' ' + a.CONTENT_S
                        WHEN @pKeyType = '1' AND ISNULL(@pKeyWord, '') > '' THEN a.TITLE
                        WHEN @pKeyType = '2' AND ISNULL(@pKeyWord, '') > '' THEN a.CONTENT_F
                        WHEN @pKeyType = '3' AND ISNULL(@pKeyWord, '') > '' THEN a.CONTENT_S
                        ELSE '' END) LIKE '%' + ISNULL(@pKeyWord, '') + '%'
            AND a.REGIST_DATE BETWEEN @vRegistDate1 AND @vRegistDate2
            AND a.UPDATE_DATE BETWEEN @vUpdateDate1 AND @vUpdateDate2
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;