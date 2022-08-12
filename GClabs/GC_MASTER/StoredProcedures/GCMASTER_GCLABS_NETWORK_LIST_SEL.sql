USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_NETWORK_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 네트워크

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_GCLABS_NETWORK_LIST_SEL]
(
    @pType          VARCHAR(3)  = '',
    @pDateType      VARCHAR(1)  = '1',  -- 1:REGIST, 2:UPDATE
    @pDatePick1     VARCHAR(10) = '2000-01-01',
    @pDatePick2     VARCHAR(10) = '2999-12-31',
    @pDatePeriod    CHAR(1)     = 'A',  -- A:All, Y:Year, Q:Quarter, M:Month
    @pViewYN        CHAR(1)     = 'A',
    @pKeyType       VARCHAR(1)  = '',   -- 1:지점명, 2:소장명
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
            a.ADDRESS,
            ISNULL(network_lo_cd.COMM_NM, '') AS REGION_NAME,
            a.BRANCH_NAME,
            a.MANAGER_NAME,
            a.VIEW_CNT,
            a.VIEW_YN,
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,
            a.UPDATE_DATE
        FROM dbo.BOARD_NETWORK AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS network_lo_cd
                ON  network_lo_cd.GRP_CD = 'network_lo_cd'
                AND network_lo_cd.COMM_CD = a.REGION_CODE
        WHERE   a.IDX > 0
            AND a.VIEW_YN = CASE WHEN @pViewYN = 'A' THEN a.VIEW_YN ELSE @pViewYN END
            AND a.BRANCH_NAME LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '1') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.MANAGER_NAME LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '2') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.REGIST_DATE BETWEEN @vRegistDate1 AND @vRegistDate2
            AND a.UPDATE_DATE BETWEEN @vUpdateDate1 AND @vUpdateDate2
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;