USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_GCLABS_NETWORK_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCRL / 재단소개 / 네트워크

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_GCLABS_NETWORK_LIST_SEL]
(
    @pType          VARCHAR(3)      = '',
    @pBranchName    NVARCHAR(30)    = '',
    @pRegionCode    NVARCHAR(30)    = ''

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN


    SELECT  a.IDX,
            
            a.BRANCH_NAME,
            a.MANAGER_NAME,
            a.MAP_TAG,

            a.LATITUDE,
            a.LONGITUDE,
            
            a.REGION_CODE,
            ISNULL(network_div.COMM_NM, '') AS REGION_NAME,
            a.ADDRESS,

            CASE WHEN a.TEL_NO_VIEW = 1 THEN a.TEL_NO_1 + '-' + a.TEL_NO_2 + '-' + a.TEL_NO_3 ELSE '' END AS TEL_NO,
            CASE WHEN a.FAX_NO_VIEW = 1 THEN a.FAX_NO_1 + '-' + a.FAX_NO_2 + '-' + a.FAX_NO_3 ELSE '' END AS FAX_NO

        FROM dbo.BOARD_NETWORK AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS network_div
                ON  network_div.GRP_CD = 'network_lo_cd'
                AND network_div.COMM_CD = a.REGION_CODE
        WHERE   a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.BRANCH_NAME LIKE '%' + @pBranchName + '%'
            AND a.REGION_CODE = CASE WHEN @pRegionCode > ' ' THEN @pRegionCode ELSE a.REGION_CODE END
        ORDER BY a.BRANCH_NAME, a.IDX DESC


END
SET NOCOUNT OFF;