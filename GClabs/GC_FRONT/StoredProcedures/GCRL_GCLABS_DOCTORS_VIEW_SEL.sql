USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_GCLABS_DOCTORS_VIEW_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-02-24
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        GCMASTER / 고객지원 / 공통

    ASSUMPTION

    EXAMPLE


======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_GCLABS_DOCTORS_VIEW_SEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    DECLARE @tblBoardDoctors  TABLE
    (
        ROW_NO  INT,
        IDX     INT,
        PRIMARY KEY (ROW_NO, IDX)
    )

    INSERT INTO @tblBoardDoctors
    SELECT  ROW_NUMBER() OVER(ORDER BY CASE WHEN a.TYPE = '069' THEN a.NAME_ENG ELSE a.NAME END, a.VIEW_ORDER ASC, a.IDX DESC),
            a.IDX
        FROM dbo.BOARD_DOCTORS AS a
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'


    DECLARE @selectedRowNo INT;

    SELECT  @selectedRowNo = ROW_NO
        FROM @tblBoardDoctors
        WHERE IDX = @pIDX

    SELECT  a.IDX,

            ISNULL(doctor_div.COMM_NM, '') AS DEPT_NAME,

            a.NAME,
            a.NAME_ENG,
            a.SUMMARY,

            ISNULL(p.IDX, 0) AS PREV_IDX,
            ISNULL(p.NAME, '') AS PREV_NAME,
            ISNULL(n.IDX, 0) AS NEXT_IDX,
            ISNULL(n.NAME, '') AS NEXT_NAME
        FROM dbo.BOARD_DOCTORS AS a
            LEFT OUTER JOIN dbo.COMMON_CODE_DT AS doctor_div
                ON  doctor_div.GRP_CD = 'doctor_div'
                AND doctor_div.COMM_CD = a.DEPT_CODE
            LEFT OUTER JOIN dbo.BOARD_DOCTORS AS p
                ON  p.[TYPE] = a.[TYPE]
                AND p.IDX = (SELECT IDX FROM @tblBoardDoctors WHERE ROW_NO = @selectedRowNo - 1)
            LEFT OUTER JOIN dbo.BOARD_DOCTORS AS n
                ON  n.[TYPE] = a.[TYPE]
                AND n.IDX = (SELECT IDX FROM @tblBoardDoctors WHERE ROW_NO = @selectedRowNo + 1)
        WHERE   a.[TYPE] = @pType
            AND a.IDX = @pIDX


    SELECT  a.IDX,
            a.NAME,
            a.[YEAR],
            a.SOURCE,

            a.ATTACH_ORG_NAME,
            a.ATTACH_SAVE_NAME
        FROM dbo.BOARD_DOCTORS_PAPER AS a
        WHERE   a.[TYPE] = @pType
            AND a.DOCTORS_IDX = @pIDX
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
        ORDER BY a.IDX DESC

END
SET NOCOUNT OFF;