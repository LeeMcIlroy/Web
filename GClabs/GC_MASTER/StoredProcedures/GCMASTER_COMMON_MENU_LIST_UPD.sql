USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_MENU_LIST_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-05-20
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 메뉴관리

    ASSUMPTION

    EXAMPLE

    select * from MEMBER_ADMIN


======================================================================*/
ALTER PROCEDURE [dbo].[GCMASTER_COMMON_MENU_LIST_UPD]
(

    @MENU_DATAS         NVARCHAR(MAX)   = '',
    @REGIST_IDX         INT
)
AS

SET NOCOUNT ON;

BEGIN


    DECLARE @registDate     DATETIME    = GETDATE(),
            @docHandle      INT         = 0,
            @resultCount    INT         = 0;


    EXECUTE sp_xml_preparedocument @docHandle OUTPUT, @MENU_DATAS;


    MERGE dbo.COMMON_MENU_AUTH AS a
        USING
        (
            SELECT  IDX AS IDX, AUTH_CODE AS AUTH_CODE, ISNULL(USE_YN, 0) AS USE_YN
                FROM OPENXML(@docHandle, N'ArrayOfMenuAuth/MenuAuth')
                WITH (
                    IDX         INT         'IDX/text()',
                    AUTH_CODE   VARCHAR(30) 'AUTH_CODE/text()',
                    USE_YN      BIT         'USE_YN/text()'
                )
        ) AS b
            ON (a.IDX = b.IDX AND a.AUTH_CODE = b.AUTH_CODE)
        WHEN MATCHED AND (a.USE_YN <> b.USE_YN) THEN
            UPDATE
                SET a.USE_YN        = b.USE_YN,
                    a.UPDATE_IDX    = @REGIST_IDX,
                    a.UPDATE_DATE   = @registDate
        WHEN NOT MATCHED AND (b.USE_YN = 1) THEN
            INSERT  (
                        IDX, AUTH_CODE, USE_YN,
                        REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
                    )
                VALUES
                    (
                        b.IDX, b.AUTH_CODE, b.USE_YN,
                        @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
                    )
        ;

    SET @resultCount = @@ROWCOUNT;

    EXECUTE sp_xml_removedocument @docHandle;
    
    SELECT @resultCount AS RESULT;

END
SET NOCOUNT OFF;