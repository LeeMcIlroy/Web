USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_PAPER_DELETE_DEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-17
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_PAPER_DELETE_DEL]
(
    @pType          VARCHAR(3),
    @pDoctorsIDX    INT,
    @pIDX           INT
)
AS

SET NOCOUNT ON;

BEGIN

    DELETE FROM dbo.BOARD_DOCTORS_PAPER
        WHERE   [TYPE] = @pType
            AND DOCTORS_IDX = @pDoctorsIDX
            AND IDX = @pIDX


    SELECT @@ROWCOUNT;


END
SET NOCOUNT OFF;