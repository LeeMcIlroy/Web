USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_VIEW_SEL]
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
            a.VIEW_ORDER,

            a.NAME,
            a.NAME_ENG,
            a.DEPT_CODE,
            a.SUMMARY,

            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,

            ISNULL(updater.ADM_ID, '') AS UPDATE_ID,
            ISNULL(updater.ADM_NAME, '') AS UPDATE_NAME,
            a.UPDATE_DATE
        FROM dbo.BOARD_DOCTORS AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.UPDATE_IDX
        WHERE   a.[TYPE]    = @pType
            AND a.IDX       = @pIDX

END
SET NOCOUNT OFF;