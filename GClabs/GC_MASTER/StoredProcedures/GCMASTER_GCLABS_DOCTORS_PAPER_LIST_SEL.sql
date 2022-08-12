USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_PAPER_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의 / 논문

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_PAPER_LIST_SEL]
(
    @pType          VARCHAR(3)  = '',
    @pDoctorsIDX    INT,
    @pKeyType       VARCHAR(1)  = '',   -- 1:논문명, 2:년도, 3:출처
    @pKeyWord       NVARCHAR(30) = ''

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.DOCTORS_IDX,
            a.IDX,
            a.NAME,
            a.[YEAR],
            a.SOURCE,
            a.VIEW_YN,
            CASE WHEN ISNULL(a.ATTACH_ORG_NAME, '') > ' ' THEN 'Y' ELSE 'N' END AS ATTACH_FILE,
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,
            a.UPDATE_DATE
        FROM dbo.BOARD_DOCTORS_PAPER AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
        WHERE   a.[TYPE]    = @pType
            AND a.DOCTORS_IDX   = @pDoctorsIDX
            AND a.IDX > 0
            AND a.[NAME] LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '1') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.[YEAR] LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '2') THEN '%' + @pKeyWord + '%' ELSE '%' END
            AND a.[SOURCE] LIKE CASE WHEN (@pKeyType = '' OR @pKeyType = '3') THEN '%' + @pKeyWord + '%' ELSE '%' END
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;