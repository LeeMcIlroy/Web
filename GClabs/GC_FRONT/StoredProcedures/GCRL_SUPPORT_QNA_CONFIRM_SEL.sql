USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_SUPPORT_QNA_CONFIRM_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_SUPPORT_QNA_CONFIRM_SEL]
(
    @pType      VARCHAR(3)  = '',
    @pEmmail    VARCHAR(100),
    @pPassword  VARCHAR(30)

)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX
        FROM dbo.BOARD_QNA AS a
        WHERE   a.[TYPE] = @pType
            AND a.EMAIL = @pEmmail
            AND a.[PASSWORD] = @pPassword

END
SET NOCOUNT OFF;