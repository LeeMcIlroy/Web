USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_BOARD_COMMON_DELETE_DEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 게시판 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_BOARD_COMMON_DELETE_DEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET NOCOUNT ON;

BEGIN

    DELETE FROM dbo.BOARD_COMMON
        WHERE   [TYPE] = @pType
            AND IDX = @pIDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;