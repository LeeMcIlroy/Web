USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_BOARD_COMMON_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-02
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 게시판 / 공통

    ASSUMPTION

    EXAMPLE

======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_BOARD_COMMON_CREATE_UPD]
(
    @TYPE               VARCHAR(3),
    
    @VIEW_ORDER         INT,
    @VIEW_YN            CHAR(1),
    @VIEW_DATE_YMD      VARCHAR(10),
    @VIEW_DATE_HM       VARCHAR(5),
    @NOTI_YN            CHAR(1),
    
    @TITLE              NVARCHAR(250)   = '',
    @CONTENT_S          NVARCHAR(250)   = '',
    @CONTENT_F          NVARCHAR(MAX)   = '',

    @DIV_CODE1          VARCHAR(30)     = '',
    @DIV_CODE2          VARCHAR(30)     = '',
    @DIV_VALUE1         INT             = 0,
    @DIV_VALUE2         INT             = 0,
    @DIV_DATE1          DATETIME        = NULL,

    @IMAGE1_ORG_NAME     NVARCHAR(255)  = '',
    @IMAGE1_SAVE_NAME    VARCHAR(255)   = '',
    @IMAGE1_SIZE         INT            = 0,

    @IMAGE2_ORG_NAME     NVARCHAR(255)  = '',
    @IMAGE2_SAVE_NAME    VARCHAR(255)   = '',
    @IMAGE2_SIZE         INT            = 0,

    @ATTACH1_ORG_NAME   NVARCHAR(255)   = '',
    @ATTACH1_SAVE_NAME  VARCHAR(255)    = '',
    @ATTACH1_SIZE       INT             = 0,

    @ATTACH2_ORG_NAME   NVARCHAR(255)   = '',
    @ATTACH2_SAVE_NAME  VARCHAR(255)    = '',
    @ATTACH2_SIZE       INT             = 0,

    @LINK1_NAME         NVARCHAR(100)   = '',
    @LINK1_URL          NVARCHAR(255)   = '',

    @LINK2_NAME         NVARCHAR(100)   = '',
    @LINK2_URL          NVARCHAR(255)   = '',

    @LINK3_NAME         NVARCHAR(100)   = '',
    @LINK3_URL          NVARCHAR(255)   = '',

    @REGIST_IDX         INT
)

AS
SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT,
            @registDate DATETIME = GETDATE(),
            @viewDate   DATETIME = GETDATE(),
            @viewYMDHM  VARCHAR(16) = '';

    SET @viewYMDHM = @VIEW_DATE_YMD + ' ' + CASE WHEN LEN(@VIEW_DATE_HM) = 5 THEN @VIEW_DATE_HM ELSE '00:00' END;

    IF (ISDATE(@viewYMDHM) = 1)
        SET @viewDate = CONVERT(DATETIME, @viewYMDHM);


    SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
        FROM dbo.BOARD_COMMON
        WHERE   [TYPE] = @TYPE
            AND IDX > 0

    INSERT
        INTO BOARD_COMMON
            (
                [TYPE], IDX, VIEW_ORDER, VIEW_YN, VIEW_DATE, NOTI_YN,
                TITLE, CONTENT_S, CONTENT_F,
                DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2, DIV_DATE1,
                IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
                IMAGE2_ORG_NAME, IMAGE2_SAVE_NAME, IMAGE2_SIZE,
                ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
                ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
                LINK1_NAME, LINK1_URL,
                LINK2_NAME, LINK2_URL,
                LINK3_NAME, LINK3_URL,
                REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
            )
        VALUES
            (
                @TYPE, @idx, @VIEW_ORDER, @VIEW_YN, @viewDate, @NOTI_YN,
                @TITLE, ISNULL(@CONTENT_S, ''), @CONTENT_F,
                ISNULL(@DIV_CODE1, ''), ISNULL(@DIV_CODE2, ''), ISNULL(@DIV_VALUE1, 0), ISNULL(@DIV_VALUE2, 0), @DIV_DATE1,
                @IMAGE1_ORG_NAME, @IMAGE1_SAVE_NAME, @IMAGE1_SIZE,
                @IMAGE2_ORG_NAME, @IMAGE2_SAVE_NAME, @IMAGE2_SIZE,
                @ATTACH1_ORG_NAME, @ATTACH1_SAVE_NAME, @ATTACH1_SIZE,
                @ATTACH2_ORG_NAME, @ATTACH2_SAVE_NAME, @ATTACH2_SIZE,
                @LINK1_NAME, @LINK1_URL,
                @LINK2_NAME, @LINK2_URL,
                @LINK3_NAME, @LINK3_URL,
                @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
            )

    SELECT @idx;


END
SET NOCOUNT OFF;