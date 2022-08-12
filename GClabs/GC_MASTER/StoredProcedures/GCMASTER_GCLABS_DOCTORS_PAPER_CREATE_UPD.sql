USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_PAPER_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의 / 논문

    ASSUMPTION

    EXAMPLE

    sp_help BOARD_DOCTORS_PAPER

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_PAPER_CREATE_UPD]
(
    @TYPE               VARCHAR(3),
    @DOCTORS_IDX        INT,

    @VIEW_YN            CHAR(1),

    @NAME               NVARCHAR(300),
    @YEAR               VARCHAR(4),
    @SOURCE             NVARCHAR(100),
    @ATTACH_ORG_NAME    NVARCHAR(255)   = '',
    @ATTACH_SAVE_NAME   VARCHAR(255)    = '',
    @ATTACH_SIZE        INT             = 0,

    @REGIST_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE();

    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.BOARD_DOCTORS_PAPER
        WHERE   [TYPE] = @TYPE
            AND DOCTORS_IDX = @DOCTORS_IDX
            AND IDX > 0

    INSERT
        INTO dbo.BOARD_DOCTORS_PAPER
            (
                [TYPE], DOCTORS_IDX, IDX, VIEW_YN, 
                [NAME], [YEAR], SOURCE,
                ATTACH_ORG_NAME, ATTACH_SAVE_NAME, ATTACH_SIZE,
                REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
            )
        VALUES
            (
                @TYPE, @DOCTORS_IDX, @idx, @VIEW_YN,
                @NAME, @YEAR, @SOURCE,
                @ATTACH_ORG_NAME, @ATTACH_SAVE_NAME, @ATTACH_SIZE,
                @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
            )

    SELECT @idx;


END
SET NOCOUNT OFF;