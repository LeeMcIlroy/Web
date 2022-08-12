USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_GCLABS_NETWORK_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-12
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 재단소개 / 네트워크

    ASSUMPTION

    EXAMPLE

======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_GCLABS_NETWORK_CREATE_UPD]
(
    @TYPE               VARCHAR(3),

    @VIEW_YN            CHAR(1),

    @BRANCH_NAME        NVARCHAR(100),
    @MANAGER_NAME       NVARCHAR(100)   = '',
    @MAP_TAG            NVARCHAR(MAX)   = '',
    @LATITUDE           DECIMAL(12,9),
    @LONGITUDE          DECIMAL(12,9),
    @REGION_CODE        VARCHAR(50),
    @ADDRESS            NVARCHAR(300),
    @TEL_NO_1           VARCHAR(4)  = '',
    @TEL_NO_2           VARCHAR(4)  = '',
    @TEL_NO_3           VARCHAR(4)  = '',
    @TEL_NO_VIEW        BIT         = '1',
    @FAX_NO_1           VARCHAR(4)  = '',
    @FAX_NO_2           VARCHAR(4)  = '',
    @FAX_NO_3           VARCHAR(4)  = '',
    @FAX_NO_VIEW        BIT         = '1',

    @REGIST_IDX     INT

)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE();

    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.BOARD_NETWORK
        WHERE   IDX > 0

    INSERT
        INTO dbo.BOARD_NETWORK
            (
                IDX, VIEW_YN, 
                BRANCH_NAME, MANAGER_NAME, MAP_TAG, LATITUDE, LONGITUDE,
                REGION_CODE, [ADDRESS],
                TEL_NO_1, TEL_NO_2, TEL_NO_3, TEL_NO_VIEW,
                FAX_NO_1, FAX_NO_2, FAX_NO_3, FAX_NO_VIEW,
                REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
            )
        VALUES
            (
                @idx, @VIEW_YN,
                @BRANCH_NAME, @MANAGER_NAME, ISNULL(@MAP_TAG, ''), @LATITUDE, @LONGITUDE,
                @REGION_CODE, @ADDRESS,
                @TEL_NO_1, @TEL_NO_2, @TEL_NO_3, @TEL_NO_VIEW,
                @FAX_NO_1, @FAX_NO_2, @FAX_NO_3, @FAX_NO_VIEW,
                @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
            )

    SELECT @idx;


END
SET NOCOUNT OFF;