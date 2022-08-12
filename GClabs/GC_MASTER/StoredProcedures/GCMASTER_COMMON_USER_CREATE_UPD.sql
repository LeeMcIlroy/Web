USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_CREATE_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-04
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자관리

    ASSUMPTION

    EXAMPLE

======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_CREATE_UPD]
(
    @USE_YN         CHAR(1),
    @ADM_ID         VARCHAR(20),
    @ADM_NAME       NVARCHAR(10),
    @ADM_PWD        VARCHAR(20),
    @PHONE          VARCHAR(15) = '',
    @EMAIL          VARCHAR(100) = '',

    @AUTH_CODE      VARCHAR(5)  = '',
    @DEPT_CODE      VARCHAR(5)  = '',

    @QNA_MAIL_TO    VARCHAR(1000)   = '',
    @QNA_MAIL_CC    VARCHAR(1000)   = '',
    @QNA_MAIL_BCC   VARCHAR(1000)   = '',

    @REGIST_IDX     INT
)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @idx        INT = 0,
            @registDate DATETIME = GETDATE();

    IF (NOT EXISTS(SELECT IDX FROM dbo.MEMBER_ADMIN WHERE IDX > 0 AND ADM_ID = @ADM_ID))
        BEGIN

            SELECT  @idx = ISNULL(MAX(IDX), 0) + 1
                FROM dbo.MEMBER_ADMIN
                WHERE   IDX > 0

            INSERT
                INTO MEMBER_ADMIN
                    (
                        IDX, USE_YN,
                        ADM_ID, ADM_NAME, ADM_PWD,
                        PHONE, EMAIL,
                        AUTH_CODE, DEPT_CODE,
                        QNA_MAIL_TO, QNA_MAIL_CC, QNA_MAIL_BCC,
                        REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
                    )
                VALUES
                    (
                        @idx, @USE_YN,
                        @ADM_ID, @ADM_NAME, @ADM_PWD,
                        @PHONE, @EMAIL,
                        @AUTH_CODE, ISNULL(@DEPT_CODE, ''),
                        ISNULL(@QNA_MAIL_TO, ''), ISNULL(@QNA_MAIL_CC, ''), ISNULL(@QNA_MAIL_BCC, ''),
                        @REGIST_IDX, @registDate, @REGIST_IDX, @registDate
                    )

        END
    ELSE
        BEGIN
            SET @idx = -1;
        END

    SELECT @idx;


END
SET NOCOUNT OFF;