USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCMASTER_COMMON_USER_ACCESSHISTORY_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-05
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 공통 / 관리자 접속이력

    ASSUMPTION

    EXAMPLE


======================================================================*/
alter PROCEDURE [dbo].[GCMASTER_COMMON_USER_ACCESSHISTORY_SEL]
(
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN


    SELECT  ROW_NUMBER() OVER(ORDER BY a.ACCESS_DATE) AS ROW_NO,
            a.ACCESS_DATE,
            a.IPADDRESS
        FROM dbo.MEMBER_ADMIN_ACCESS_HISTORY AS a
        WHERE   a.IDX = @pIDX
        ORDER BY ROW_NO DESC


END
SET NOCOUNT OFF;