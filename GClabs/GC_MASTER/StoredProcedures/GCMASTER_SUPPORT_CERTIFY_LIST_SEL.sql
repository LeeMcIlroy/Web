USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_SUPPORT_CERTIFY_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 인증현황

    ASSUMPTION

    EXAMPLE

    execute GCMASTER_SUPPORT_CERTIFY_LIST_SEL



    sp_help BOARD_CERTIFY
======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_SUPPORT_CERTIFY_LIST_SEL]
(
    @pType          VARCHAR(3)  = '',
    @pDateType      VARCHAR(1)  = '1',  -- 1:REGIST, 2:UPDATE
    @pDatePick1     VARCHAR(10) = '2000-01-01',
    @pDatePick2     VARCHAR(10) = '2999-12-31',
    @pDatePeriod    CHAR(1)     = 'A',  -- A:All, Y:Year, Q:Quarter, M:Month
    @pViewYN        CHAR(1)     = 'A',
    @pNotiYN        CHAR(1)     = 'A',
    @pCategoryCode  VARCHAR(50) = '',
    @pKeyType       VARCHAR(1)  = '',   -- 1:프로그램명, 2:인증서명
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

            a.VIEW_CNT,
            a.VIEW_YN,
            a.VIEW_ORDER,
            a.NOTI_YN,

            CASE WHEN a.CATEGORY_CODE = '01' THEN certi_div_cd.COMM_NM ELSE '-' END AS CATEGORY_NAME1,
            CASE WHEN a.CATEGORY_CODE = '02' THEN certi_div_cd.COMM_NM ELSE '-' END AS CATEGORY_NAME2,

            a.CERTIFY_NAME,

            a.IMAGE_SAVE_NAME,
            
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,
            a.UPDATE_DATE
        FROM dbo.BOARD_CERTIFY AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS certi_div_cd
                ON  certi_div_cd.GRP_CD = 'certi_div_cd'
                AND certi_div_cd.COMM_CD = a.CATEGORY_CODE
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = CASE WHEN @pViewYN = 'A' THEN a.VIEW_YN ELSE @pViewYN END
            AND a.NOTI_YN = CASE WHEN @pNotiYN = 'A' THEN a.NOTI_YN ELSE @pNotiYN END
            AND a.CATEGORY_CODE LIKE CASE WHEN @pCategoryCode > ' ' THEN @pCategoryCode ELSE '%' END
            AND (CASE   WHEN @pKeyType = '' AND ISNULL(@pKeyWord, '') > ' ' THEN a.PROGRAM_NAME + ' ' + a.CERTIFY_NAME
                        WHEN @pKeyType = '1' AND ISNULL(@pKeyWord, '') > ' ' THEN a.PROGRAM_NAME
                        WHEN @pKeyType = '1' AND ISNULL(@pKeyWord, '') > ' ' THEN a.CERTIFY_NAME
                        ELSE '' END) LIKE '%' + @pKeyWord + '%'
            AND a.REGIST_DATE BETWEEN @vRegistDate1 AND @vRegistDate2
            AND a.UPDATE_DATE BETWEEN @vUpdateDate1 AND @vUpdateDate2
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;