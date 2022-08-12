USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_GCLABS_DOCTORS_LIST_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE

select * from BOARD_DOCTORS

======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_GCLABS_DOCTORS_LIST_SEL]
(
    @pType      VARCHAR(3)  = '',
    @pDeptCode  VARCHAR(30) = ''
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    SELECT  a.IDX,

            a.NAME,
            A.NAME_ENG,

            a.REGIST_DATE
        FROM dbo.BOARD_DOCTORS AS a
            /*
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS doctor_div
                ON  doctor_div.GRP_CD = 'doctor_div'
                AND doctor_div.COMM_CD = a.DEPT_CODE
            */
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.DEPT_CODE = CASE WHEN @pDeptCode > ' ' THEN @pDeptCode ELSE a.DEPT_CODE END
        ORDER BY CASE WHEN a.TYPE = '069' THEN a.NAME_ENG ELSE a.NAME END, a.VIEW_ORDER ASC, a.IDX DESC


END
SET NOCOUNT OFF;