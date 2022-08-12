USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_BOARD_COMMON_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 게시판 / 공통

    ASSUMPTION

    EXAMPLE

    

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_BOARD_COMMON_VIEW_SEL]
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
            a.VIEW_DATE,
            CONVERT(VARCHAR(10), a.VIEW_DATE, 120) AS VIEW_DATE_YMD,
            CONVERT(VARCHAR(5), a.VIEW_DATE, 108) AS VIEW_DATE_HM,
            a.NOTI_YN,

            a.TITLE,
            a.CONTENT_S,
            a.CONTENT_F,
            
            a.DIV_CODE1,
            a.DIV_CODE2,
            a.DIV_VALUE1,
            CONVERT(VARCHAR(10), ISNULL(a.DIV_DATE1, GETDATE()), 120) AS DIV_DATE1,

            a.IMAGE1_ORG_NAME,
            a.IMAGE1_SAVE_NAME,
            a.IMAGE1_SIZE,

            a.IMAGE2_ORG_NAME,
            a.IMAGE2_SAVE_NAME,
            a.IMAGE2_SIZE,

            a.ATTACH1_ORG_NAME,
            a.ATTACH1_SAVE_NAME,
            a.ATTACH1_SIZE,

            a.ATTACH2_ORG_NAME,
            a.ATTACH2_SAVE_NAME,
            a.ATTACH2_SIZE,

            a.LINK1_NAME,
            a.LINK1_URL,

            a.LINK2_NAME,
            a.LINK2_URL,

            a.LINK3_NAME,
            a.LINK3_URL,

            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,

            ISNULL(updater.ADM_ID, '') AS UPDATE_ID,
            ISNULL(updater.ADM_NAME, '') AS UPDATE_NAME,
            a.UPDATE_DATE
        FROM dbo.BOARD_COMMON AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.UPDATE_IDX
        WHERE   a.[TYPE] = @pType
            AND a.IDX = @pIDX

END
SET NOCOUNT OFF;