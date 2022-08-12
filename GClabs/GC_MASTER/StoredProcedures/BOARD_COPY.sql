

/*

검사관리 > 장비소개

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '013'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '013',[EQUIPMENT_IDX],
            [USE_YN],[REGDATE],10,0,'N',
            CASE [DIVCODE]
                WHEN '010' THEN '09'
                WHEN '020' THEN '07'
                WHEN '030' THEN '11'
                WHEN '040' THEN '15'
                WHEN '050' THEN '03'
                WHEN '060' THEN '10'
                WHEN '070' THEN '01'
                WHEN '080' THEN '05'
                
                ELSE '00' END, '', [CNT], 0,
            [NAME],[EQUIPMENTUSE], '',      
            [ATTACH_NAME],[ATTACH_SAVE_NAME],[ATTACH_SIZE],
            1, [REGDATE], 1, [REGDATE]
        FROM [GCRL].[dbo].[EQUIPMENT]



국문 장비소개 -> 영문 장비소개
INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '072', IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        FROM GCRL.dbo.BOARD_COMMON
        WHERE [TYPE] = '013'


SELECT  *
        FROM [GCRL].[dbo].[EQUIPMENT]
        where DIVCODE = '110'

-----
    <option value="010">혈액학</option>
        <option value="09">혈액팀</option>

    <option value="020">자동화검사</option>
        <option value="07">자동화검사</option>

    <option value="030">특수생화학</option>
        <option value="11">특수생화학</option>

    <option value="040">요검경</option>
        <option value="15">요검경</option>

    <option value="050">면역(효소/방사)</option>
        <option value="03">면역</option>

    <option value="060">미생물</option>
        <option value="10">미생물팀</option>

    <option value="070">분자유전</option>
        <option value="01">분자유전</option>

    <option value="080">세포유전</option>
        <option value="05">세포유전</option>


------
    <option value="090">병리학부</option>
        <option value="04">세포병리</option>
        <option value="08">조직병리</option>
        <option value="14">면역병리</option>
        <option value="13">분자병리</option>

    <option value="100">임상연구</option>
    <option value="110">국가과제</option>

    <option value="02">결핵진단</option>
    <option value="06">인간유전</option>
*/




/*

고객지원 > GC Lab 공문

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '021'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '021',[DOC_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            '', '', 0, 0,
            [SUBJECT], [SUBJECT],[CONTENT],
            [ATTACH_NAME],[ATTACH_SAVE_NAME],[ATTACH_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[DOC]

*/



/*

고객지원 > 신규검사

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '022'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '022',[NEW_TEST_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            '', '', 0, 0,
            [SUBJECT], [SUBJECT],[CONTENT],
            IMG_NAME, IMG_NAME, IMG_SIZE,
            [ATTACH_NAME],[ATTACH_SAVE_NAME],[ATTACH_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[NEW_TEST]

*/




/*

고객지원 > info & tech

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '023'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '023',[LAB_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            [LAB_YEAR], [LAB_QUARTER], 0, 0,
            [SUBJECT], '',[CONTENT],
            [PIC1], [PIC1], 0,
            [ATTACH_NAME],[ATTACH_SAVE_NAME],[ATTACH_SIZE],
            [ATTACHB_NAME],[ATTACHB_SAVE_NAME],[ATTACHB_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[LAB]

*/


/*

고객지원 > 인증현황

delete from GCRL.dbo.BOARD_CERTIFY where [TYPE] = '024'

INSERT INTO GCRL.dbo.BOARD_CERTIFY
        (
            [TYPE], [IDX],
            [VIEW_YN], [VIEW_DATE], [VIEW_ORDER], [VIEW_CNT], [NOTI_YN],
            [CATEGORY_CODE], [CERTIFY_NAME], [PROGRAM_NAME], [COUNTRY_NAME], [ISSUER_NAME], [ISSUE_DATE], [CERTIFY_CONTENT], [ANALYSIS_ITEM],
            [IMAGE_ORG_NAME], [IMAGE_SAVE_NAME], [IMAGE_SIZE],
            [ATTACH_ORG_NAME], [ATTACH_SAVE_NAME], [ATTACH_SIZE],
            [REGIST_IDX], [REGIST_DATE], [UPDATE_IDX], [UPDATE_DATE]
        )
    SELECT  '024', [CEERTIFICATE_IDX],
            [USE_YN], [REGDATE], 10, 0, 'N',
            '01', [CEERTIFICATE_NAME], [NAME], [NATION], [ISSUINGORG], [DATE], [CONTENTS], [ANALYSIS],
            [KOR_IMG], [KOR_IMG_SAVE], [KOR_IMG_SIZE],
            [KOR_IMG], [KOR_IMG_SAVE], [KOR_IMG_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[CEERTIFICATE]
        WHERE CATEGORY = '010'

INSERT INTO GCRL.dbo.BOARD_CERTIFY
        (
            [TYPE], [IDX],
            [VIEW_YN], [VIEW_DATE], [VIEW_ORDER], [VIEW_CNT], [NOTI_YN],
            [CATEGORY_CODE], [CERTIFY_NAME], [PROGRAM_NAME], [COUNTRY_NAME], [ISSUER_NAME], [ISSUE_DATE], [CERTIFY_CONTENT], [ANALYSIS_ITEM],
            [IMAGE_ORG_NAME], [IMAGE_SAVE_NAME], [IMAGE_SIZE],
            [ATTACH_ORG_NAME], [ATTACH_SAVE_NAME], [ATTACH_SIZE],
            [REGIST_IDX], [REGIST_DATE], [UPDATE_IDX], [UPDATE_DATE]
        )
    SELECT  '024', [CEERTIFICATE_IDX],
            [USE_YN], [REGDATE], 10, 0, 'N',
            '02', [CEERTIFICATE_NAME], [NAME], [NATION], [ISSUINGORG], [DATE], [CONTENTS], [ANALYSIS],
            [ENG_IMG], [ENG_IMG_SAVE], [ENG_IMG_SIZE],
            [ENG_IMG], [ENG_IMG_SAVE], [ENG_IMG_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[CEERTIFICATE]
        WHERE CATEGORY = '020'

*/


/*

고객지원 > 검사약어

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '025'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '025',[WORD_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            '', '', 0, 0,
            [NAME], [ENAME],[CONTENT],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[WORD]
*/


/*

고객지원 > 학술발표

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '027'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '027',[SCHOLARLY_IDX],
            [USE_YN],[REGDATE],10,0,'N',
            --[DIVCODE], [SCHOLARLY_YEAR], 0, 0,
            [SCHOLARLY_YEAR], '', 0, 0,
            [SCHOLARLY_NAME],'',[SUBJECT],
            [ATTACH_NAME],[ATTACH_SAVE_NAME],[ATTACH_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[SCHOLARLY]
  
*/



/*
고객문의 > QNA
delete from GCRL.dbo.BOARD_QNA where [TYPE] = '031'

INSERT INTO GCRL.dbo.BOARD_QNA
        (
            [TYPE],[IDX],[QUESTION_DATE],[QUESTION_TYPE]
            ,[NAME],[COUNTRY_NAME],[REGION_NAME],[ORG_NAME],[DEPT_NAME]
            ,[CONTACT],[EMAIL],[PASSWORD]
            ,[TITLE],[CONTENTS]
            ,[ATTACH1_ORG_NAME],[ATTACH1_SAVE_NAME]
            ,[CHECK_DATE]
            ,[ANS_ST]
            ,[ANS_TITLE]
            ,[ANS_SENDEMAIL]
            ,[ANS_CONTENTS]
            ,[ATTACH2_ORG_NAME],[ATTACH2_SAVE_NAME]
            ,[ANS_REG_IDX],[ANS_REG_DATE],[ANS_UPD_IDX],[ANS_UPD_DATE]
        )
    SELECT  '031',[INQUIRY_IDX],[REGDATE],
            case [DIVCODE]
                when '030' then '05'
                when '040' then '05'
                when '050' then '01'
                when '060' then '01'
                when '070' then '05'
                when '080' then '04'
                when '090' then '05'
                when '100' then '05'
                else '05' end,
            [NAME],'',isnull([AREA], ''),isnull([COMPANY], ''),isnull([DEPARTMENT], ''),
            [PHONE],[EMAIL],isnull([PASSWORD], ''),
            [TITLE],[CONTENT],
            [ATTACH_NAME], [ATTACH_SAVE_NAME],
            [CONFIRMDATE],
            left([STATUS], 2),
            [REPLY_TITLE],
            [REPLY_SEND_YN],
            [REPLY],
            [REPLY_ATTACH_NAME],[REPLY_ATTACH_SAVE_NAME],
            case when [STATUS] = '030' then 1 else null end, [REPLYDATE],case when [STATUS] = '030' then 1 else null end,[REPLYDATE]
        FROM [GCRL].[dbo].[INQUIRY]
        where DIVCODE >= '030'

030:일반문의        => 05
040:이벤트          => 05
050:일반검사문의     => 01
060:신규검사문의     => 01
070:병원관리문의     => 05
080:마케팅홍보문의   => 04
090:개선사항        => 05
100:기타문의        => 05

01:검사관련문의
02:임상연구문의
03:대사체연구문의
04:마케팅홍보문의
05:기타문의
06:IVD임상시험문의



*/


/*

고객문의 > FAQ

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '032'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '032',[FAQ_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            '01', '', 0, 0,
            [SUBJECT],'',[CONTENT],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[FAQ]
  
*/


/*

재단홍보 > 언론보도

4:언론보도

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '041'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '041',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],[TOP_FLAG],
            '', '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            REAL_IMG_NAME,SAVE_IMG_NAME,0,
            REAL_FILE_NAME,SAVE_FILE_NAME,FILE_SIZE,
            REAL_FILE_NAME2,SAVE_FILE_NAME2,FILE_SIZE2,
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[FOUNDATION_NEWS]
        WHERE BOARD_TYPE='4'
  
1:공지사항
3:소식

5:사회공헌
*/

/*

재단홍보 > 재단소식

1:공지사항
3:소식

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '043'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '043',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],[TOP_FLAG],
            CASE BOARD_TYPE WHEN '1' THEN '02' ELSE '01' END, '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            REAL_IMG_NAME,SAVE_IMG_NAME,0,
            REAL_FILE_NAME,SAVE_FILE_NAME,FILE_SIZE,
            REAL_FILE_NAME2,SAVE_FILE_NAME2,FILE_SIZE2,
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[FOUNDATION_NEWS]
        WHERE BOARD_TYPE IN ('1', '3')
*/



/*

재단홍보 > 홍보영상

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '044'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '044',[PUBLICITY_IDX],
            [USE_YN],[REGDATE],10,[VIEWCNT],'N',
            '', '', 0, 0,
            [SUBJECT], 'https://www.youtube.com/embed/' + [URL],[CONTENT],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[PUBLICITY]
*/

/*

재단홍보 > 사회공헌

5:사회공헌

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '045'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '045',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],[TOP_FLAG],
            '', '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            REAL_IMG_NAME,SAVE_IMG_NAME,0,
            REAL_FILE_NAME,SAVE_FILE_NAME,FILE_SIZE,
            REAL_FILE_NAME2,SAVE_FILE_NAME2,FILE_SIZE2,
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[FOUNDATION_NEWS]
        WHERE BOARD_TYPE='5'
*/


/*

재단소개 > 전문의

delete from GCRL.dbo.BOARD_DOCTORS where [TYPE] = '051'
delete from GCRL.dbo.BOARD_DOCTORS_PAPER where [TYPE] = '051'

INSERT INTO GCRL.dbo.BOARD_DOCTORS
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_ORDER, VIEW_CNT,
            NAME, NAME_ENG, DEPT_CODE, SUMMARY,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '051',[SPECIALIST_IDX],
            [USE_YN],10,[VIEWCNT],
            NAME, '', LEFT(DIVCODE, 2), CONTENT,
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[SPECIALIST]

INSERT INTO GCRL.dbo.BOARD_DOCTORS_PAPER
        (
            [TYPE], DOCTORS_IDX, IDX,
            VIEW_YN,
            NAME, YEAR, SOURCE,
            ATTACH_ORG_NAME, ATTACH_SAVE_NAME,  ATTACH_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '051', [SPECIALIST_IDX], SPECIALIST_PAPER_IDX,
            [USE_YN],
            TITLE, YEAR, SOURCE,
            ATTACH_NAME, ATTACH_SAVE_NAME, ATTACH_SIZE,
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[SPECIALIST_PAPER]

*/


/*

재단소개 > 네크워크

delete from GCRL.dbo.[BOARD_NETWORK]

INSERT INTO GCRL.dbo.BOARD_NETWORK
        (
            [IDX],
            [VIEW_YN],[VIEW_CNT],
            [BRANCH_NAME],[MANAGER_NAME],[MAP_TAG],
            [REGION_CODE],[ADDRESS],
            [TEL_NO_1],[TEL_NO_2],[TEL_NO_3],[TEL_NO_VIEW],
            [FAX_NO_1],[FAX_NO_2],[FAX_NO_3],[FAX_NO_VIEW],
            [REGIST_IDX],[REGIST_DATE],[UPDATE_IDX],[UPDATE_DATE]
        )
    SELECT  [NETWORK_IDX],
            [USE_YN],[VIEWCNT],
            OFFICE, MANAGER, MAP,
            
            CASE ADDR1
                WHEN N'서울특별시' THEN '01'
                WHEN N'인천광역시' THEN '02'
                WHEN N'광주광역시' THEN '03'
                WHEN N'대구광역시' THEN '04'
                WHEN N'대전광역시' THEN '05'
                WHEN N'부산광역시' THEN '06'
                WHEN N'울산광역시' THEN '07'
                WHEN N'강원도' THEN '08'
                WHEN N'경기도' THEN '09'
                WHEN N'경상남도' THEN '10'
                WHEN N'경상북도' THEN '11'
                WHEN N'전라남도' THEN '12'
                WHEN N'전라북도' THEN '13'
                WHEN N'충청남도' THEN '14'
                WHEN N'충청북도' THEN '15'
                WHEN N'제주도' THEN '16'
                WHEN N'울릉도' THEN '17'
            ELSE '' END
            ,
            ADDR2,
            left([phone], fst-1),
            SUBSTRING([phone], fst+1, snd - fst - 1),
            replace(right(rtrim([phone]), 4), '-', ''),
            '1',
            '', '', '', '0',
            1,[REGDATE],1,[REGDATE]
        FROM (
            SELECT *,
                    CHARINDEX('-', [phone]) as fst,
                    CHARINDEX('-', [phone], (CHARINDEX('-', [phone]) + 1)) as snd
                FROM [GCRL].[dbo].[NETWORK]
        ) as x




*/



/*

Eng > Test Tpdates

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '061'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2, DIV_DATE1,
            TITLE, CONTENT_S, CONTENT_F,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '061',[IDX],
            [VIEW_FLAG], [REG_DATE], 10, [READ_CNT], 'N',
            CASE [BOARD_TYPE]
                WHEN '1' THEN '01'
                WHEN '2' THEN '02'
                WHEN '3' THEN '03'
                WHEN '4' THEN '04'
                WHEN '5' THEN '05'
                ELSE '' END, '', 0, 0, [SAVE_DATE],
            [SUBJECT], [CODE], [CONTENTS],
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[TESTITEM_ENG]

*/



/*

Eng > Certifications

delete from GCRL.dbo.BOARD_CERTIFY where [TYPE] = '063'

INSERT INTO GCRL.dbo.BOARD_CERTIFY
        (
            [TYPE], [IDX],
            [VIEW_YN], [VIEW_DATE], [VIEW_ORDER], [VIEW_CNT], [NOTI_YN],
            [CATEGORY_CODE], [CERTIFY_NAME], [PROGRAM_NAME], [COUNTRY_NAME], [ISSUER_NAME], [ISSUE_DATE], [CERTIFY_CONTENT], [ANALYSIS_ITEM],
            [IMAGE_ORG_NAME], [IMAGE_SAVE_NAME], [IMAGE_SIZE],
            [ATTACH_ORG_NAME], [ATTACH_SAVE_NAME], [ATTACH_SIZE],
            [REGIST_IDX], [REGIST_DATE], [UPDATE_IDX], [UPDATE_DATE]
        )
    SELECT  '063', [CEERTIFICATE_IDX],
            [USE_YN], [REGDATE], [SORT], 0, 'N',
            left(CATEGORY, 2), [CEERTIFICATE_NAME], '', '', '', '', '', '',
            [ENG_IMG], [ENG_IMG_SAVE], [ENG_IMG_SIZE],
            [PRINT1_IMG], [PRINT1_IMG_SAVE], [PRINT1_IMG_SIZE],
            1,[REGDATE],1,[REGDATE]
        FROM [GCRL].[dbo].[CEERTIFICATE_ENG]


*/



/*

Eng > Pr

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '064'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '064',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],'N',
            '', '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[PRESS_ENG]
*/


/*

Eng > Newsletter

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '065'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '065',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],'N',
            '', '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            [REAL_IMG_NAME], [SAVE_IMG_NAME], 0,
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[NEWSLETTER_ENG]
    UNION ALL
    SELECT  '065',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],'N',
            '02', '', 0, 0,
            [SUBJECT],'',[CONTENTS],
            [REAL_IMG_NAME], [SAVE_IMG_NAME], 0,
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[NEWS_ENG]
*/



/*

Eng > info & tech

delete from GCRL.dbo.BOARD_COMMON where [TYPE] = '066'

INSERT INTO GCRL.dbo.BOARD_COMMON
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_DATE, VIEW_ORDER, VIEW_CNT, NOTI_YN,
            DIV_CODE1, DIV_CODE2, DIV_VALUE1, DIV_VALUE2,
            TITLE, CONTENT_S, CONTENT_F,
            IMAGE1_ORG_NAME, IMAGE1_SAVE_NAME, IMAGE1_SIZE,
            ATTACH1_ORG_NAME, ATTACH1_SAVE_NAME, ATTACH1_SIZE,
            ATTACH2_ORG_NAME, ATTACH2_SAVE_NAME, ATTACH2_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '066',[IDX],
            [VIEW_FLAG],[REG_DATE],10,[READ_CNT],'N',
            DATEPART(YEAR, [REG_DATE]), DATEPART(QUARTER, [REG_DATE]), 0, 0,
            [SUBJECT], '',[CONTENTS],
            [REAL_IMG_NAME], [SAVE_IMG_NAME], 0,
            [REAL_FILE_NAME],[SAVE_FILE_NAME],[FILE_SIZE],
            [REAL_FILE_NAME],[SAVE_FILE_NAME],[FILE_SIZE],
            1,[REG_DATE],1,[REG_DATE]
        FROM [GCRL].[dbo].[NEWTEST_ENG]

*/



/*
Eng > Contact Us

delete from GCRL.dbo.BOARD_QNA where [TYPE] = '071'

INSERT INTO GCRL.dbo.BOARD_QNA
        (
            [TYPE],[IDX],[QUESTION_DATE],[QUESTION_TYPE]
            ,[NAME],[COUNTRY_NAME],[REGION_NAME],[ORG_NAME],[DEPT_NAME]
            ,[CONTACT],[EMAIL],[PASSWORD]
            ,[TITLE],[CONTENTS]
            ,[ATTACH1_ORG_NAME],[ATTACH1_SAVE_NAME]
            ,[CHECK_DATE]
            ,[ANS_ST]
            ,[ANS_TITLE]
            ,[ANS_SENDEMAIL]
            ,[ANS_CONTENTS]
            ,[ATTACH2_ORG_NAME],[ATTACH2_SAVE_NAME]
            ,[ANS_REG_IDX],[ANS_REG_DATE],[ANS_UPD_IDX],[ANS_UPD_DATE]
        )
    SELECT  '071',[INQUIRY_IDX],[REGDATE],'05',
            [NAME],isnull([COUNTRY], ''),isnull([CITY], ''),isnull([ORGANIZATION], ''),'',
            [PHONE],[EMAIL],'',
            left(convert(nvarchar(max), [CONTENT]), 20) + ' .....',[CONTENT],
            [ATTACH_NAME], [ATTACH_SAVE_NAME],
            [CONFIRMDATE],
            left([STATUS], 2),
            [REPLY_TITLE],
            [REPLY_SEND_YN],
            [REPLY],
            [REPLY_ATTACH_NAME],[REPLY_ATTACH_SAVE_NAME],
            case when [STATUS] = '030' then 1 else null end, [REPLYDATE],case when [STATUS] = '030' then 1 else null end,[REPLYDATE]
        FROM [GCRL].[dbo].[INQUIRY_ENG]

*/



/*

delete from GCRL.dbo.BOARD_DOCTORS where [TYPE] = '069'
delete from GCRL.dbo.BOARD_DOCTORS_PAPER where [TYPE] = '069'

INSERT INTO GCRL.dbo.BOARD_DOCTORS
        (
            [TYPE], IDX,
            VIEW_YN, VIEW_ORDER, VIEW_CNT,
            NAME, NAME_ENG, DEPT_CODE, SUMMARY,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '069', IDX,
            VIEW_YN, VIEW_ORDER, VIEW_CNT,
            NAME, NAME_ENG, DEPT_CODE, SUMMARY,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        FROM [GCRL].[dbo].[BOARD_DOCTORS]
        where [Type] = '051'

INSERT INTO GCRL.dbo.BOARD_DOCTORS_PAPER
        (
            [TYPE], DOCTORS_IDX, IDX,
            VIEW_YN,
            NAME, YEAR, SOURCE,
            ATTACH_ORG_NAME, ATTACH_SAVE_NAME,  ATTACH_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        )
    SELECT  '069', DOCTORS_IDX, IDX,
            VIEW_YN,
            NAME, YEAR, SOURCE,
            ATTACH_ORG_NAME, ATTACH_SAVE_NAME,  ATTACH_SIZE,
            REGIST_IDX, REGIST_DATE, UPDATE_IDX, UPDATE_DATE
        FROM [GCRL].[dbo].[BOARD_DOCTORS_PAPER]
        where [Type] = '051'


*/