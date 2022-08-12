USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_SUPPORT_CERTIFY_EDIT_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-01-22
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_SUPPORT_CERTIFY_EDIT_UPD]
(
    @TYPE               VARCHAR(3),
    @IDX                INT,
    
    @VIEW_ORDER         INT,
    @VIEW_YN            CHAR(1),
    @VIEW_DATE_YMD      VARCHAR(10),
    @VIEW_DATE_HM       VARCHAR(5),
    @NOTI_YN            CHAR(1),
    
    @CATEGORY_CODE      VARCHAR(50),
    @CERTIFY_NAME       NVARCHAR(100),
    @PROGRAM_NAME       NVARCHAR(100)   = '',
    @COUNTRY_NAME       NVARCHAR(100)   = '',
    @ISSUER_NAME        NVARCHAR(100)   = '',
    @ISSUE_DATE         NVARCHAR(100)   = '',
    @CERTIFY_CONTENT    NVARCHAR(100)   = '',
    @ANALYSIS_ITEM      NVARCHAR(100)   = '',

    @IMAGE_ORG_NAME     NVARCHAR(255)    = '',
    @IMAGE_SAVE_NAME    VARCHAR(255)    = '',
    @IMAGE_SIZE         INT             = 0,

    @ATTACH_ORG_NAME    NVARCHAR(255)   = '',
    @ATTACH_SAVE_NAME   VARCHAR(255)    = '',
    @ATTACH_SIZE        INT             = 0,

    @UPDATE_IDX         INT

)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @viewDate   DATETIME = GETDATE(),
            @viewYMDHM  VARCHAR(16) = '';

    SET @viewYMDHM = @VIEW_DATE_YMD + ' ' + CASE WHEN LEN(@VIEW_DATE_HM) = 5 THEN @VIEW_DATE_HM ELSE '00:00' END;

    IF (ISDATE(@viewYMDHM) = 1)
        SET @viewDate = CONVERT(DATETIME, @viewYMDHM);


    UPDATE  dbo.BOARD_CERTIFY
        SET     VIEW_ORDER      = @VIEW_ORDER,
                VIEW_YN         = @VIEW_YN,
                VIEW_DATE       = @viewDate,
                NOTI_YN         = @NOTI_YN,

                CATEGORY_CODE   = @CATEGORY_CODE,
                CERTIFY_NAME    = @CERTIFY_NAME,
                PROGRAM_NAME    = ISNULL(@PROGRAM_NAME, ''),
                COUNTRY_NAME    = @COUNTRY_NAME,
                ISSUER_NAME     = @ISSUER_NAME,
                ISSUE_DATE      = @ISSUE_DATE,
                CERTIFY_CONTENT = @CERTIFY_CONTENT,
                ANALYSIS_ITEM   = @ANALYSIS_ITEM,

                IMAGE_ORG_NAME      = @IMAGE_ORG_NAME,
                IMAGE_SAVE_NAME     = @IMAGE_SAVE_NAME,
                IMAGE_SIZE          = @IMAGE_SIZE,

                ATTACH_ORG_NAME     = @ATTACH_ORG_NAME,
                ATTACH_SAVE_NAME    = @ATTACH_SAVE_NAME,
                ATTACH_SIZE         = @ATTACH_SIZE,

                UPDATE_IDX      = @UPDATE_IDX,
                UPDATE_DATE     = GETDATE()
        WHERE   [TYPE]  = @TYPE
            AND IDX     = @IDX


    SELECT @@ROWCOUNT;

END
SET NOCOUNT OFF;