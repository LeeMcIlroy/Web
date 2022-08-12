USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_NETWORK_DELETE_DEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 네트워크

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_GCLABS_NETWORK_DELETE_DEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET NOCOUNT ON;

BEGIN

    DELETE FROM dbo.BOARD_NETWORK
        WHERE   IDX = @pIDX


    SELECT @@ROWCOUNT;


END
SET NOCOUNT OFF;