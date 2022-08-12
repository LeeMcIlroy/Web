USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_SUPPORT_QNA_WRITE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-25
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCLR / 고객지원 / QNA

    ASSUMPTION

    EXAMPLE

======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_SUPPORT_QNA_WRITE_UPD]
(
    @TYPE               VARCHAR(3),
    @QUESTION_TYPE      VARCHAR(50),
    @NAME               NVARCHAR(30),
    @COUNTRY_NAME       NVARCHAR(50)    = '',
    @REGION_NAME        NVARCHAR(50),
    @ORG_NAME           NVARCHAR(50),
    @DEPT_NAME          NVARCHAR(50)    = '',
    @CONTACT            VARCHAR(11),
    @EMAIL              VARCHAR(100),
    @PASSWORD           VARCHAR(30)     = '',
    @TITLE              NVARCHAR(50),
    @CONTENTS           NVARCHAR(MAX),
    @ATTACH1_ORG_NAME   NVARCHAR(255)   = '',
    @ATTACH1_SAVE_NAME  VARCHAR(255)    = ''
)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE()
            ;


    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.BOARD_QNA
        WHERE   [TYPE] = @TYPE
            AND IDX > 0

    INSERT
        INTO BOARD_QNA
            (
                [TYPE], IDX,
                QUESTION_DATE, QUESTION_TYPE, [NAME], COUNTRY_NAME, REGION_NAME, ORG_NAME, DEPT_NAME, CONTACT, EMAIL, [PASSWORD], [TITLE], CONTENTS,
                ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME,
                ANS_ST
            )
        VALUES
            (
                @TYPE, @idx,
                GETDATE(), @QUESTION_TYPE, @NAME, ISNULL(@COUNTRY_NAME, ''), @REGION_NAME, @ORG_NAME, ISNULL(@DEPT_NAME, ''), @CONTACT, @EMAIL, ISNULL(@PASSWORD, ''), @TITLE, @CONTENTS,
                ISNULL(@ATTACH1_ORG_NAME, ''), ISNULL(@ATTACH1_SAVE_NAME, ''),
                '01'
            )

    SELECT @idx;


END
SET NOCOUNT OFF;