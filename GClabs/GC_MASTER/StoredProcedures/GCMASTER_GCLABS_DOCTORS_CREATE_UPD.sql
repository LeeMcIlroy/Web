USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의

    ASSUMPTION

    EXAMPLE

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_CREATE_UPD]
(
    @TYPE               VARCHAR(3),

    @VIEW_ORDER         INT,
    @VIEW_YN            CHAR(1),

    @NAME               NVARCHAR(10)    = '',
    @NAME_ENG           VARCHAR(30)     = '',
    @DEPT_CODE          VARCHAR(50)     = '',
    @SUMMARY            NVARCHAR(MAX)   = '',

    @REGIST_IDX     INT

)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE();

    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.BOARD_DOCTORS
        WHERE   [TYPE] = @TYPE
            AND IDX > 0

    INSERT
        INTO dbo.BOARD_DOCTORS
            (
                [TYPE], IDX, VIEW_ORDER, VIEW_YN, 
                [NAME], NAME_ENG, DEPT_CODE, SUMMARY,
                REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
            )
        VALUES
            (
                @TYPE, @idx, @VIEW_ORDER, @VIEW_YN,
                @NAME, @NAME_ENG, @DEPT_CODE, @SUMMARY,
                @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
            )

    SELECT @idx;


END
SET NOCOUNT OFF;