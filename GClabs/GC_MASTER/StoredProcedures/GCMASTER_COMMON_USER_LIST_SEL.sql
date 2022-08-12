USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자관리

    ASSUMPTION

    EXAMPLE

    select * from MEMBER_ADMIN


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_LIST_SEL]
(
    @pDateType      VARCHAR(1)  = '1',  -- 1:REGIST, 2:UPDATE
    @pDatePick1     VARCHAR(10) = '2000-01-01',
    @pDatePick2     VARCHAR(10) = '2099-12-31',
    @pDatePeriod    CHAR(1)     = 'A',  -- A:All, Y:Year, Q:Quarter, M:Month
    @pUseYN         CHAR(1)     = 'A',
    @pAuthType      VARCHAR(5)  = '',   -- 
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
            a.USE_YN,

            a.ADM_ID,
            a.ADM_NAME,

            ISNULL(admin_auth_div.COMM_NM, '') AS AUTH_NAME,
            ISNULL(admin_dept_div.COMM_NM, '') AS DEPT_NAME,

            a.ACCESS_DATE,

            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,
            a.UPDATE_DATE
        FROM dbo.MEMBER_ADMIN AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS admin_auth_div
                ON  admin_auth_div.GRP_CD = 'admin_auth_div'
                AND admin_auth_div.COMM_CD = a.AUTH_CODE
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS admin_dept_div
                ON  admin_dept_div.GRP_CD = 'admin_dept_div'
                AND admin_dept_div.COMM_CD = a.DEPT_CODE
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
        WHERE   a.IDX > 0
            AND a.USE_YN = CASE WHEN @pUseYN = 'A' THEN a.USE_YN ELSE @pUseYN END
            AND a.ADM_ID LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '1') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.ADM_NAME LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '2') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.REGIST_DATE BETWEEN @vRegistDate1 AND @vRegistDate2
            AND a.UPDATE_DATE BETWEEN @vUpdateDate1 AND @vUpdateDate2
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;