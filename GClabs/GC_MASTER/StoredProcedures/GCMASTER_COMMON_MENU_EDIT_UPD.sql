USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_MENU_EDIT_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-05-23
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 메뉴

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_COMMON_MENU_EDIT_UPD]
(
    @IDX                INT,
    
    @GROUP_CODE         VARCHAR(50),
    @CONTROLLER         VARCHAR(50),
    @ACTION             VARCHAR(50),
    @NAME               NVARCHAR(50),
    @USE_YN             CHAR(1),

    @UPDATE_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN
    UPDATE  dbo.COMMON_MENU
        SET     GROUP_CODE      = @GROUP_CODE,
                CONTROLLER      = @CONTROLLER,
                [ACTION]        = @ACTION,
                [NAME]          = @NAME,
                USE_YN          = @USE_YN,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   IDX = @IDX

    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;