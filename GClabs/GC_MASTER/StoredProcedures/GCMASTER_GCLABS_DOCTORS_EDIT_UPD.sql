USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_DOCTORS_EDIT_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 전문의

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_GCLABS_DOCTORS_EDIT_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,
    
    @VIEW_ORDER         INT,
    @VIEW_YN            CHAR(1),

    @NAME               NVARCHAR(10)    = '',
    @NAME_ENG           VARCHAR(30)     = '',
    @DEPT_CODE          VARCHAR(50)     = '',
    @SUMMARY            NVARCHAR(MAX)   = '',

    @UPDATE_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN


    UPDATE  dbo.BOARD_DOCTORS
        SET     VIEW_ORDER      = @VIEW_ORDER,
                VIEW_YN         = @VIEW_YN,

                [NAME]          = @NAME,
                NAME_ENG        = @NAME_ENG,
                DEPT_CODE       = @DEPT_CODE,
                SUMMARY         = @SUMMARY,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   [TYPE]  = @TYPE
            AND IDX     = @IDX


    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;