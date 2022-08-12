USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자관리

    ASSUMPTION

    EXAMPLE

    

======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_VIEW_SEL]
(
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,

            a.USE_YN,

            a.ADM_ID,
            a.ADM_NAME,
            a.ADM_PWD,
            a.PHONE,
            a.EMAIL,

            a.AUTH_CODE,
            a.DEPT_CODE,

            ISNULL(a.QNA_MAIL_TO, '') AS QNA_MAIL_TO,
            ISNULL(a.QNA_MAIL_CC, '') AS QNA_MAIL_CC,
            ISNULL(a.QNA_MAIL_BCC, '') AS QNA_MAIL_BCC,

            a.ACCESS_DATE,

            registor.ADM_ID AS REGIST_ID,
            registor.ADM_NAME AS REGIST_NAME,
            a.REGIST_DATE,

            ISNULL(updater.ADM_ID, '') AS UPDATE_ID,
            ISNULL(updater.ADM_NAME, '') AS UPDATE_NAME,
            a.UPDATE_DATE
        FROM dbo.MEMBER_ADMIN AS a
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.REGIST_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.UPDATE_IDX
        WHERE   a.IDX = @pIDX

END
SET NOCOUNT OFF;