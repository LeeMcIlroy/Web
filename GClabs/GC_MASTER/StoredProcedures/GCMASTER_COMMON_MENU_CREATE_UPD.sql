USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_MENU_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-05-23
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 메뉴

    ASSUMPTION

    EXAMPLE

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_COMMON_MENU_CREATE_UPD]
(
    @GROUP_CODE         VARCHAR(50),
    @CONTROLLER         VARCHAR(50),
    @ACTION             VARCHAR(50),
    @NAME               NVARCHAR(50),
    @USE_YN             CHAR(1),

    @REGIST_IDX         INT
)

AS
SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE();

    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.COMMON_MENU
        WHERE   IDX > 0

    INSERT
        INTO COMMON_MENU
            (
                IDX, GROUP_CODE, CONTROLLER, [ACTION], [NAME], USE_YN,
                REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
            )
        VALUES
            (
                @idx, @GROUP_CODE, @CONTROLLER, @ACTION, @NAME, @USE_YN,
                @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
            )

    SELECT @idx;


END
SET NOCOUNT OFF;