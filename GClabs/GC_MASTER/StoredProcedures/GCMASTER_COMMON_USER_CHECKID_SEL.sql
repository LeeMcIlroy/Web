USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_CHECKID_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자관리

    ASSUMPTION

    EXAMPLE

    

======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_CHECKID_SEL]
(
    @pIDX       INT,
    @pID        VARCHAR(20)
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX
        FROM dbo.MEMBER_ADMIN AS a
        WHERE   a.IDX <> @pIDX
            AND a.ADM_ID = @pID

END
SET NOCOUNT OFF;