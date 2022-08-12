USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_SUPPORT_CERTIFY_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 인증현황

    ASSUMPTION

    EXAMPLE

    EXECUTE GCMASTER_SUPPORT_CERTIFY_VIEW_SEL @pType='', @pIDX = 1


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_SUPPORT_CERTIFY_VIEW_SEL]
(
    @pType      VARCHAR(3)  = '',   -- '024'
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,

            a.VIEW_CNT,
            a.VIEW_YN,
            a.VIEW_ORDER,
            a.VIEW_DATE,
            CONVERT(VARCHAR(10), a.VIEW_DATE, 120) AS VIEW_DATE_YMD,
            CONVERT(VARCHAR(5), a.VIEW_DATE, 108) AS VIEW_DATE_HM,
            a.NOTI_YN,

            a.CATEGORY_CODE,
            a.CERTIFY_NAME,
            a.PROGRAM_NAME,
            a.COUNTRY_NAME,
            a.ISSUER_NAME,
            a.ISSUE_DATE,
            a.CERTIFY_CONTENT,
            a.ANALYSIS_ITEM,

            a.IMAGE_ORG_NAME,
            a.IMAGE_SAVE_NAME,
            a.IMAGE_SIZE,

            a.ATTACH_ORG_NAME,
            a.ATTACH_SAVE_NAME,
            a.ATTACH_SIZE,

            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,

            ISNULL(updater.ADM_ID, '') AS UPDATE_ID,
            ISNULL(updater.ADM_NAME, '') AS UPDATE_NAME,
            a.UPDATE_DATE
        FROM dbo.BOARD_CERTIFY AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.UPDATE_IDX
        WHERE   a.[TYPE] = @pType
            AND a.IDX = @pIDX

END
SET NOCOUNT OFF;