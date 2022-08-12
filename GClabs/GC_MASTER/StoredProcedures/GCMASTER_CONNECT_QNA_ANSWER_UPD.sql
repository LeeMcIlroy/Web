USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_ANSWER_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단홍보 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_ANSWER_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,

    @QUESTION_TYPE      VARCHAR(30),
    @ANS_TITLE          NVARCHAR(50)    = '',
    @ANS_SENDEMAIL      VARCHAR(1)      = '',
    @ANS_CONTENTS       NVARCHAR(MAX),

    @ATTACH2_ORG_NAME   VARCHAR(255)    = '',
    @ATTACH2_SAVE_NAME  NVARCHAR(255)   = '',

    @ANS_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN


    UPDATE  dbo.BOARD_QNA
        SET     QUESTION_TYPE   = @QUESTION_TYPE,
                ANS_ST          = '03',

                ANS_TITLE       = ISNULL(@ANS_TITLE, ''),
                ANS_SENDEMAIL   = @ANS_SENDEMAIL,
                ANS_CONTENTS    = @ANS_CONTENTS,

                ATTACH2_ORG_NAME    = @ATTACH2_ORG_NAME,
                ATTACH2_SAVE_NAME   = @ATTACH2_SAVE_NAME,

                ANS_REG_IDX     = CASE WHEN ANS_REG_IDX IS NULL THEN @ANS_IDX ELSE ANS_REG_IDX END,
                ANS_REG_DATE    = CASE WHEN ANS_REG_DATE IS NULL THEN GETDATE() ELSE ANS_REG_DATE END,
                ANS_UPD_IDX     = @ANS_IDX,
                ANS_UPD_DATE    = GETDATE()
        WHERE   [TYPE] = @TYPE
            AND IDX = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;