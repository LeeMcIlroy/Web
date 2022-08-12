USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_PAPER_EDIT_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-17
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의 / 논문

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_PAPER_EDIT_UPD]
(
    @TYPE               VARCHAR(3),

    @DOCTORS_IDX        INT,
    @IDX                INT,

    @VIEW_YN            CHAR(1),

    @NAME               NVARCHAR(300),
    @YEAR               VARCHAR(4),
    @SOURCE             NVARCHAR(100),
    @ATTACH_ORG_NAME    NVARCHAR(255)   = '',
    @ATTACH_SAVE_NAME   VARCHAR(255)    = '',
    @ATTACH_SIZE        INT             = 0,

    @UPDATE_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN


    UPDATE  dbo.BOARD_DOCTORS_PAPER
        SET     VIEW_YN         = @VIEW_YN,

                [NAME]              = @NAME,
                [YEAR]              = @YEAR,
                SOURCE              = @SOURCE,
                ATTACH_ORG_NAME     = @ATTACH_ORG_NAME,
                ATTACH_SAVE_NAME    = @ATTACH_SAVE_NAME,
                ATTACH_SIZE         = @ATTACH_SIZE,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   [TYPE]      = @TYPE
            AND DOCTORS_IDX = @DOCTORS_IDX
            AND IDX         = @IDX


    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;