USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_DELETE_FILE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단홍보 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_DELETE_FILE_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,

    @ANS_IDX         INT
)
AS

SET NOCOUNT ON;

BEGIN

    UPDATE  dbo.BOARD_QNA
        SET     ATTACH2_ORG_NAME    = '',
                ATTACH2_SAVE_NAME   = '',

                ANS_UPD_IDX     = @ANS_IDX,
                ANS_UPD_DATE    = GETDATE()
        WHERE   [TYPE] = @TYPE
            AND IDX = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;