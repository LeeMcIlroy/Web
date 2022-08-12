USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_CONNECT_QNA_DELETE_DEL]
    AUTHOR      AnSeongYeol
    DATE        2022-05-17
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / CONNECT / QNA

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_CONNECT_QNA_DELETE_DEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET NOCOUNT ON;

BEGIN

    DELETE FROM dbo.BOARD_QNA
        WHERE   [TYPE] = @pType
            AND IDX = @pIDX


    SELECT @@ROWCOUNT;


END
SET NOCOUNT OFF;