USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단홍보 / 공통

    ASSUMPTION
        @pKeyType : 전체조회 없음.

    EXAMPLE


    select * from BOARD_QNA


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_LIST_SEL]
(
    @pType          VARCHAR(3)  = '',
    @pDateType      VARCHAR(1)  = '1',  -- 1:REGIST, 2:UPDATE
    @pDatePick1     VARCHAR(10) = '2000-01-01',
    @pDatePick2     VARCHAR(10) = '2999-12-31',
    @pDatePeriod    CHAR(1)     = 'A',  -- A:All, Y:Year, Q:Quarter, M:Month
    @pAnsSt         VARCHAR(30) = '',
    @pQnaType       VARCHAR(30) = '',
    @pKeyType       VARCHAR(1)  = '',   -- 1:작성자, 2:기관명, 3:내용
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
            a.QUESTION_DATE,
            ISNULL(qna_div.COMM_NM, '') AS QUESTION_NAME,
            a.ORG_NAME,
            a.NAME,
            a.TITLE,
            ISNULL(qna_ans.COMM_NM, '') AS ANS_ST_NAME,
            ISNULL(registor.ADM_NAME, '') AS ANS_REG_NAME,
            ISNULL(a.ANS_SENDEMAIL, '') AS ANS_SENDEMAIL,
            CONVERT(VARCHAR(10), a.ANS_REG_DATE, 120) AS ANS_REG_YMD
        FROM dbo.BOARD_QNA AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS qna_div
                ON  qna_div.GRP_CD = 'qna_div'
                AND qna_div.COMM_CD = a.QUESTION_TYPE
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS qna_ans
                ON  qna_ans.GRP_CD = 'qna_ans'
                AND qna_ans.COMM_CD = a.ANS_ST
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.ANS_REG_IDX
        WHERE   a.TYPE = @pType
            AND a.IDX > 0
            AND a.QUESTION_TYPE = CASE WHEN ISNULL(@pQnaType, '') = '' THEN a.QUESTION_TYPE ELSE @pQnaType END
            AND a.ANS_ST = CASE WHEN ISNULL(@pAnsSt, '') > ' ' THEN @pAnsSt ELSE a.ANS_ST END
            AND a.NAME LIKE CASE WHEN @pKeyType = '1' THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.ORG_NAME LIKE CASE WHEN @pKeyType = '2' THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.CONTENTS LIKE CASE WHEN @pKeyType = '3' THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.QUESTION_DATE BETWEEN @vRegistDate1 AND @vRegistDate2
            --AND a.UPDATE_DATE BETWEEN @vUpdateDate1 AND @vUpdateDate2
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;