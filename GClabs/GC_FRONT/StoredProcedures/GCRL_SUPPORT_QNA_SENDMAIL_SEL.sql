USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_SUPPORT_QNA_SENDMAIL_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 

    ASSUMPTION

    EXAMPLE

execute GCRL_SUPPORT_QNA_SENDMAIL_SEL
@pInqrCode = '07'

======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_SUPPORT_QNA_SENDMAIL_SEL]
(
    @pInqrCode      VARCHAR(30)
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  b.ADM_NAME AS 'Name',
            b.EMAIL AS 'Email',
            CASE    WHEN ISNULL(b.QNA_MAIL_TO, '') LIKE '%' + @pInqrCode + '%' THEN 'TO'
                    WHEN ISNULL(b.QNA_MAIL_CC, '') LIKE '%' + @pInqrCode + '%' THEN 'CC'
                    WHEN ISNULL(b.QNA_MAIL_BCC, '') LIKE '%' + @pInqrCode + '%' THEN 'BCC'
                    ELSE '' END AS 'Type'
        FROM dbo.MEMBER_ADMIN AS b
        WHERE   b.IDX > 0
            AND b.USE_YN = 'Y'
            AND (
                ISNULL(b.QNA_MAIL_TO, '') LIKE '%' + @pInqrCode + '%'
                OR ISNULL(b.QNA_MAIL_CC, '') LIKE '%' + @pInqrCode + '%'
                OR ISNULL(b.QNA_MAIL_BCC, '') LIKE '%' + @pInqrCode + '%'
            )
            AND b.EMAIL LIKE '%@%'

END
SET NOCOUNT OFF;