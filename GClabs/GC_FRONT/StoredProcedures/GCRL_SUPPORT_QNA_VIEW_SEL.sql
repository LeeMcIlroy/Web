USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_SUPPORT_QNA_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE

select * from BOARD_QNA

======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_SUPPORT_QNA_VIEW_SEL]
(
    @pType      VARCHAR(3)  = '',
    @pEmmail    VARCHAR(100),
    @pPassword  VARCHAR(30)
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,
            a.TITLE,
            a.CONTENTS,
            a.QUESTION_DATE,
            a.ANS_ST,
            ISNULL(qna_ans.COMM_NM, '') AS ANS_ST_NAME,
            a.ANS_TITLE,
            a.ANS_CONTENTS,
            a.ATTACH1_ORG_NAME,
            a.ATTACH1_SAVE_NAME,
            a.ATTACH2_ORG_NAME,
            a.ATTACH2_SAVE_NAME
        FROM dbo.BOARD_QNA AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS qna_ans
                ON  qna_ans.GRP_CD = 'qna_ans'
                AND qna_ans.COMM_CD = a.ANS_ST
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.EMAIL = @pEmmail
            AND a.[PASSWORD] = @pPassword
        ORDER BY a.QUESTION_DATE DESC, a.ANS_REG_DATE DESC

END
SET NOCOUNT OFF;