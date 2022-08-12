USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_CHANGE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-04-26
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_CHANGE_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,

    @QUESTION_TYPE      VARCHAR(30),

    @ANS_IDX            INT
)
AS

SET NOCOUNT ON;

BEGIN


    UPDATE  dbo.BOARD_QNA
        SET     QUESTION_TYPE   = @QUESTION_TYPE
        WHERE   [TYPE] = @TYPE
            AND IDX = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;