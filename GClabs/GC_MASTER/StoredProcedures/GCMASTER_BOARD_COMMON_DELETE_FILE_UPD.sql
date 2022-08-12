USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_BOARD_COMMON_DELETE_FILE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-21
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_BOARD_COMMON_DELETE_FILE_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,

    @FILE_FLAG          VARCHAR(2),     -- I1, I2, F1, F2

    @UPDATE_IDX         INT
)
AS

SET NOCOUNT ON;

BEGIN

    UPDATE  dbo.BOARD_COMMON
        SET     IMAGE1_ORG_NAME    = CASE WHEN @FILE_FLAG = 'I1' THEN '' ELSE IMAGE1_ORG_NAME END,
                IMAGE1_SAVE_NAME    = CASE WHEN @FILE_FLAG = 'I1' THEN '' ELSE IMAGE1_SAVE_NAME END,
                IMAGE1_SIZE    = CASE WHEN @FILE_FLAG = 'I1' THEN 0 ELSE IMAGE1_SIZE END,

                IMAGE2_ORG_NAME    = CASE WHEN @FILE_FLAG = 'I2' THEN '' ELSE IMAGE2_ORG_NAME END,
                IMAGE2_SAVE_NAME    = CASE WHEN @FILE_FLAG = 'I2' THEN '' ELSE IMAGE2_SAVE_NAME END,
                IMAGE2_SIZE    = CASE WHEN @FILE_FLAG = 'I2' THEN 0 ELSE IMAGE2_SIZE END,

                ATTACH1_ORG_NAME    = CASE WHEN @FILE_FLAG = 'F1' THEN '' ELSE ATTACH1_ORG_NAME END,
                ATTACH1_SAVE_NAME    = CASE WHEN @FILE_FLAG = 'F1' THEN '' ELSE ATTACH1_SAVE_NAME END,
                ATTACH1_SIZE    = CASE WHEN @FILE_FLAG = 'F1' THEN 0 ELSE ATTACH1_SIZE END,

                ATTACH2_ORG_NAME    = CASE WHEN @FILE_FLAG = 'F2' THEN '' ELSE ATTACH2_ORG_NAME END,
                ATTACH2_SAVE_NAME    = CASE WHEN @FILE_FLAG = 'F2' THEN '' ELSE ATTACH2_SAVE_NAME END,
                ATTACH2_SIZE    = CASE WHEN @FILE_FLAG = 'F2' THEN 0 ELSE ATTACH2_SIZE END,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   [TYPE] = @TYPE
            AND IDX = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;