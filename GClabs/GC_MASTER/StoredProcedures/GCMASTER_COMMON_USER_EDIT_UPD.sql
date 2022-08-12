USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_EDIT_UPD]
    AUTHOR      AnSeongYeol
    DATE        2022-02-04
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자관리

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_EDIT_UPD]
(
    @IDX            INT,
    @USE_YN         CHAR(1),
    @ADM_ID         VARCHAR(20),
    @ADM_NAME       NVARCHAR(10),
    @ADM_PWD        VARCHAR(20) = '',

    @PHONE          VARCHAR(15) = '',
    @EMAIL          VARCHAR(100) = '',

    @AUTH_CODE      VARCHAR(5)  = '',
    @DEPT_CODE      VARCHAR(5)  = '',

    @QNA_MAIL_TO    VARCHAR(1000)   = '',
    @QNA_MAIL_CC    VARCHAR(1000)   = '',
    @QNA_MAIL_BCC   VARCHAR(1000)   = '',

    @UPDATE_IDX     INT

)
AS

SET NOCOUNT ON;

BEGIN

    DECLARE @updateDate     DATETIME = GETDATE(),
            @cngUSE_YN      BIT = 0,
            @cngADM_ID      BIT = 0,
            @cngADM_NAME    BIT = 0,
            @cngADM_PWD     BIT = 0,
            @cngPHONE       BIT = 0,
            @cngEMAIL       BIT = 0,
            @cngAUTH_CODE   BIT = 0,
            @cngDEPT_CODE   BIT = 0,
            @cngQNA_MAIL_TO BIT = 0,
            @cngQNA_MAIL_CC BIT = 0,
            @cngQNA_MAIL_BCC BIT = 0;

    ;

    IF (EXISTS(SELECT IDX FROM dbo.MEMBER_ADMIN WHERE IDX <> @IDX AND ADM_ID = @ADM_ID))
        BEGIN

            SELECT -1;

        END
    ELSE
        BEGIN

            SELECT  @cngUSE_YN      = CASE WHEN USE_YN <> @USE_YN THEN 1 ELSE 0 END,
                    @cngADM_ID      = CASE WHEN ADM_ID <> @ADM_ID THEN 1 ELSE 0 END,
                    @cngADM_NAME    = CASE WHEN ADM_NAME <> @ADM_NAME THEN 1 ELSE 0 END,
                    @cngADM_PWD     = CASE WHEN (@ADM_PWD > ' ' AND ADM_PWD <> @ADM_PWD) THEN 1 ELSE 0 END,
                    @cngPHONE       = CASE WHEN PHONE <> @PHONE THEN 1 ELSE 0 END,
                    @cngEMAIL       = CASE WHEN EMAIL <> @EMAIL THEN 1 ELSE 0 END,
                    @cngAUTH_CODE   = CASE WHEN AUTH_CODE <> @AUTH_CODE THEN 1 ELSE 0 END,
                    @cngDEPT_CODE   = CASE WHEN DEPT_CODE <> ISNULL(@DEPT_CODE, '') THEN 1 ELSE 0 END,
                    @cngQNA_MAIL_TO = CASE  WHEN QNA_MAIL_TO <> ISNULL(@QNA_MAIL_TO, '') THEN 1 ELSE 0 END,
                    @cngQNA_MAIL_CC = CASE  WHEN QNA_MAIL_CC <> ISNULL(@QNA_MAIL_CC, '') THEN 1 ELSE 0 END,
                    @cngQNA_MAIL_BCC = CASE  WHEN QNA_MAIL_BCC <> ISNULL(@QNA_MAIL_BCC, '') THEN 1 ELSE 0 END
                FROM dbo.MEMBER_ADMIN
                WHERE IDX = @IDX


            UPDATE  dbo.MEMBER_ADMIN
                SET     USE_YN      = @USE_YN,
                        ADM_ID      = CASE WHEN @cngADM_ID = 1 THEN @ADM_ID ELSE ADM_ID END,
                        ADM_NAME    = @ADM_NAME,
                        ADM_PWD     = CASE WHEN @cngADM_PWD = 1 THEN @ADM_PWD ELSE ADM_PWD END,
                        PHONE       = @PHONE,
                        EMAIL       = @EMAIL,
                        AUTH_CODE   = @AUTH_CODE,
                        DEPT_CODE   = ISNULL(@DEPT_CODE, ''),

                        QNA_MAIL_TO = ISNULL(@QNA_MAIL_TO, ''),
                        QNA_MAIL_CC = ISNULL(@QNA_MAIL_CC, ''),
                        QNA_MAIL_BCC = ISNULL(@QNA_MAIL_BCC, ''),

                        UPDATE_IDX  = @UPDATE_IDX,
                        UPDATE_DATE = @updateDate
                WHERE   IDX = @IDX


            SELECT @@ROWCOUNT;


            IF (@cngUSE_YN = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'사용여부', @UPDATE_IDX, @updateDate)
                END

            IF (@cngADM_ID = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'아이디', @UPDATE_IDX, @updateDate)
                END

            IF (@cngADM_NAME = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'이름', @UPDATE_IDX, @updateDate)
                END

            IF (@cngADM_PWD = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'비밀번호', @UPDATE_IDX, @updateDate)
                END

            IF (@cngPHONE = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'연락처', @UPDATE_IDX, @updateDate)
                END

            IF (@cngEMAIL = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'이메일', @UPDATE_IDX, @updateDate)
                END

            IF (@cngAUTH_CODE = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'권한', @UPDATE_IDX, @updateDate)
                END

            IF (@cngDEPT_CODE = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'부서', @UPDATE_IDX, @updateDate)
                END

            IF (@cngQNA_MAIL_TO = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'문의 수신', @UPDATE_IDX, @updateDate)
                END

            IF (@cngQNA_MAIL_CC = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'참조 수신', @UPDATE_IDX, @updateDate)
                END

            IF (@cngQNA_MAIL_BCC = 1)
                BEGIN
                    INSERT INTO dbo.MEMBER_ADMIN_EDIT_HISTORY
                        VALUES
                            (@IDX, N'숨은참조 수신', @UPDATE_IDX, @updateDate)
                END
        END


END
SET NOCOUNT OFF;