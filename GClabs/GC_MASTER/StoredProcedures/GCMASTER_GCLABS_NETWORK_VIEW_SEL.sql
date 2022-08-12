USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_NETWORK_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 네트워크

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_GCLABS_NETWORK_VIEW_SEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,

            a.VIEW_CNT,
            a.VIEW_YN,

            a.BRANCH_NAME,
            a.MANAGER_NAME,
            a.MAP_TAG,
            a.LATITUDE,
            a.LONGITUDE,
            a.REGION_CODE,
            a.ADDRESS,
            a.TEL_NO_1,
            a.TEL_NO_2,
            a.TEL_NO_3,
            a.TEL_NO_VIEW,
            a.FAX_NO_1,
            a.FAX_NO_2,
            a.FAX_NO_3,
            a.FAX_NO_VIEW,
            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,

            ISNULL(updater.ADM_ID, '') AS UPDATE_ID,
            ISNULL(updater.ADM_NAME, '') AS UPDATE_NAME,
            a.UPDATE_DATE
        FROM dbo.BOARD_NETWORK AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.UPDATE_IDX
        WHERE   a.IDX = @pIDX

END
SET NOCOUNT OFF;