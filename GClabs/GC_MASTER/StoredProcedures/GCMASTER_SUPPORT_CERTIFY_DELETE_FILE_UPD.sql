USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_SUPPORT_CERTIFY_DELETE_FILE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-21
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_SUPPORT_CERTIFY_DELETE_FILE_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,

    @UPDATE_IDX         INT
)
AS

SET NOCOUNT ON;

BEGIN

    UPDATE  dbo.BOARD_CERTIFY
        SET     ATTACH_ORG_NAME     = '',
                ATTACH_SAVE_NAME    = '',
                ATTACH_SIZE         = 0,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   [TYPE]  = @TYPE
            AND IDX     = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;