USE [GCRL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*======================================================================
    PROGRAM     [GCRL_DEPT_EQUIPMENT_SEL]
    AUTHOR      AnSeongYeol
    DATE        2022-03-17
    EDIT        
======================================================================
    PROGRAM DESCRIPTION
        

    ASSUMPTION

    EXAMPLE


    select * from BOARD_COMMON where type = '072'


    exec GCRL_DEPT_EQUIPMENT_SEL
    @pType='072', @pIDX=0, @pCode='', @pCommPcd=''



    SELECT  ROW_NUMBER() OVER(ORDER BY a.VIEW_ORDER ASC, a.IDX DESC),
            a.IDX,
            a.TITLE,
            a.CONTENT_S,
            a.IMAGE1_SAVE_NAME
        FROM dbo.BOARD_COMMON AS a
            INNER JOIN dbo.COMMON_CODE_DT AS b
                ON  b.GRP_CD = 'dept_div_en'
                AND b.COMM_CD = a.DIV_CODE1
                --AND b.COMM_PCD = b.COMM_PCD
        WHERE   a.[TYPE] = '072'
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            --AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)
            AND a.DIV_CODE1 = a.DIV_CODE1

======================================================================*/
ALTER PROCEDURE [dbo].[GCRL_DEPT_EQUIPMENT_SEL]
(
    @pType      VARCHAR(3),
    @pIDX       INT,
    @pCode      VARCHAR(30),
    @pCommPcd   VARCHAR(30)
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

    DECLARE @tblEquipments  TABLE
    (
        ROW_NO  INT,
        IDX     INT,
        TITLE   NVARCHAR(250),
        PURPOSE NVARCHAR(250),
        IMAGE_NAME  VARCHAR(255),
        PRIMARY KEY (ROW_NO, IDX)
    )

    INSERT INTO @tblEquipments
    SELECT  ROW_NUMBER() OVER(ORDER BY a.VIEW_ORDER ASC, a.IDX DESC),
            a.IDX,
            a.TITLE,
            a.CONTENT_S,
            a.IMAGE1_SAVE_NAME
        FROM dbo.BOARD_COMMON AS a
            INNER JOIN dbo.COMMON_CODE_DT AS b
                ON  b.GRP_CD = CASE WHEN @pType = '072' THEN 'dept_div_en' ELSE 'dept_div' END
                AND b.COMM_CD = a.DIV_CODE1
                AND ISNULL(b.COMM_PCD, '') = CASE WHEN ISNULL(@pCommPcd, '') > ' ' THEN @pCommPcd ELSE ISNULL(b.COMM_PCD, '') END
        WHERE   a.[TYPE] = @pType
            AND a.IDX > 0
            AND a.VIEW_YN = 'Y'
            AND a.VIEW_DATE <= CONVERT(VARCHAR(16), GETDATE(), 120)
            AND a.DIV_CODE1 = CASE WHEN ISNULL(@pCode, '') > ' ' THEN @pCode ELSE a.DIV_CODE1 END


    DECLARE @selectedRowNo  INT;

    IF (ISNULL(@pIDX, 0) = 0)
        BEGIN
            SET @selectedRowNo = 1;
        END
    ELSE
        BEGIN
            SELECT  @selectedRowNo = ROW_NO
                FROM @tblEquipments
                WHERE IDX = @pIDX
        END


    SELECT  a.TITLE,
            a.PURPOSE,

            a.IMAGE_NAME,

            ISNULL((SELECT IDX FROM @tblEquipments WHERE ROW_NO = @selectedRowNo-1), 0) AS PREV_IDX,
            ISNULL((SELECT IDX FROM @tblEquipments WHERE ROW_NO = @selectedRowNo+1), 0) AS NEXT_IDX
        FROM @tblEquipments AS a
        WHERE a.ROW_NO = @selectedRowNo

END
SET NOCOUNT OFF;