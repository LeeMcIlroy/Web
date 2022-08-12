USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단홍보 / 공통

    ASSUMPTION

    EXAMPLE

    

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_VIEW_SEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN


    UPDATE  BOARD_QNA
        SET CHECK_DATE = GETDATE(),
            ANS_ST = '02'
        WHERE   IDX = @pIDX
            AND CHECK_DATE IS NULL


    SELECT  a.IDX,

            a.QUESTION_DATE,
            a.QUESTION_TYPE,

            a.NAME,
            a.COUNTRY_NAME,
            a.REGION_NAME,
            a.ORG_NAME,
            a.DEPT_NAME,
            a.CONTACT,
            a.EMAIL,
            a.TITLE,
            a.CONTENTS,

            a.ATTACH1_ORG_NAME,
            a.ATTACH1_SAVE_NAME,

            a.CHECK_DATE,
            a.ANS_ST,
            ISNULL(qna_ans.COMM_NM, '') AS ANS_ST_NAME,
            ISNULL(a.ANS_TITLE, '') AS ANS_TITLE,
            ISNULL(a.ANS_SENDEMAIL, 'N') AS ANS_SENDEMAIL,
            ISNULL(a.ANS_CONTENTS, '') AS ANS_CONTENTS,

            a.ATTACH2_ORG_NAME,
            a.ATTACH2_SAVE_NAME,

            registor.ADM_ID AS ANS_REG_ID,
            registor.ADM_NAME AS ANS_REG_NAME,
            a.ANS_REG_DATE,

            ISNULL(updater.ADM_ID, '') AS ANS_UPD_ID,
            ISNULL(updater.ADM_NAME, '') AS ANS_UPD_NAME,
            a.ANS_UPD_DATE
        FROM dbo.BOARD_QNA AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS qna_ans
                ON  qna_ans.GRP_CD = 'qna_ans'
                AND qna_ans.COMM_CD = a.ANS_ST
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS registor
                ON  registor.IDX = a.ANS_REG_IDX
            LEFT OUTER JOIN dbo.MEMBER_ADMIN AS updater
                ON  updater.IDX = a.ANS_UPD_IDX
        WHERE   a.TYPE = @pType
            AND a.IDX = @pIDX

END
SET NOCOUNT OFF;