USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_MENU_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-05-20
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 메뉴관리

    ASSUMPTION

    EXAMPLE

    select * from MEMBER_ADMIN


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_COMMON_MENU_LIST_SEL]
(
    @pAuthCode      VARCHAR(50) = '',
    @pGroupCode     VARCHAR(50) = ''
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,
            @pAuthCode AS AUTH_CODE,
            a.GROUP_CODE,
            ISNULL(menu_group_div.COMM_NM, '') AS GROUP_NAME,
            a.NAME,

            ISNULL(b.USE_YN, '0') AS USE_YN,

            ISNULL(registor.ADM_NAME, '') AS REGIST_NAME,
            b.REGIST_DATE,
            ISNULL(updator.ADM_NAME, '') AS UPDATE_NAME,
            b.UPDATE_DATE
        FROM dbo.COMMON_MENU AS a
            LEFT OUTER JOIN dbo.COMMON_MENU_AUTH AS b
                ON  b.IDX = a.IDX
                AND b.AUTH_CODE = @pAuthCode
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS menu_group_div
                ON  menu_group_div.GRP_CD = 'menu_group_div'
                AND menu_group_div.COMM_CD = a.GROUP_CODE
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = b.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updator
                ON  updator.IDX = b.UPDATE_IDX
        WHERE   a.IDX > 0
            AND a.GROUP_CODE = CASE WHEN ISNULL(@pGroupCode, '') > ' ' THEN @pGroupCode ELSE a.GROUP_CODE END
        ORDER BY a.IDX DESC


END
SET NOCOUNT OFF;