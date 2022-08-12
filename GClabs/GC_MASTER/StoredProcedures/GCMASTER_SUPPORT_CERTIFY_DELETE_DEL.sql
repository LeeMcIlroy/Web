USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_SUPPORT_CERTIFY_DELETE_DEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 인증현황

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_SUPPORT_CERTIFY_DELETE_DEL]
(
    @pType      VARCHAR(3)  = '',
    @pIDX       INT
)
AS

SET NOCOUNT ON;

BEGIN

    DELETE FROM dbo.BOARD_CERTIFY
        WHERE   [TYPE]  = @pType
            AND IDX     = @pIDX


    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;