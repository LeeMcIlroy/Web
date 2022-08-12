using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Core
{
    /// <summary>
    /// 공통으로 사용하든 메세지를 관리합니다.
    /// </summary>
    public class Message
    {
        /// <summary>
        /// 계산값 확인 시 메세지 
        /// : (은)는 소수점 2자리까지 가능합니다.
        /// </summary>
        public static readonly string MSG_001 = "(은)는 소수점 2자리까지 가능합니다.";

        /// <summary>
        /// 계산하기 선택 시 확인 메세지
        /// : 계산하시면 모든 데이터가 새로 계산되어 저장됩니다.\n계산하시겠습니까?
        /// </summary>
        public static readonly string MSG_002_Q = "계산하시면 모든 데이터가 새로 계산되어 저장됩니다.계산하시겠습니까?";

        /// <summary>
        /// 계산하기 완료 후 메세지
        /// : 계산되었습니다
        /// </summary>
        public static readonly string MSG_002_A = "계산되었습니다.";

        /// <summary>
        /// 계산하기 중 오류 메세지
        /// : 데이터에 오류가 있습니다.\n확인 후 다시 계산해주세요
        /// </summary>
        public static readonly string MSG_002_E = "데이터에 오류가 있습니다.확인 후 다시 계산해주세요";

        /// <summary>
        /// 초기화 선택 시 확인 메세지
        /// : 초기화 시 입력된 모든 데이터가 삭제됩니다.\n초기화 하시겠습니까?
        /// </summary>
        //public static readonly string MSG_003_Q = "초기화 시 입력된 모든 데이터가 삭제됩니다.\\n초기화 하시겠습니까?";

        public static readonly string MSG_003_Q = "초기화 시 저장되지 않은 데이터는 수정 직전값으로 돌아갑니다. 초기화하시겠습니까?";
        /// <summary>
        /// 공시관리에서 초기화 선택 시 확인 메세지
        /// : 초기화 시 입력된 모든 데이터가 삭제됩니다.\n초기화 하시겠습니까?
        /// </summary>
        public static readonly string MSG_003_W = "초기화 시 저장된 데이터는 삭제가됩니다. 초기화하시겠습니까?";

        /// <summary>
        /// 초기화 완료 후 메세지
        /// : 초기화되었습니다.
        /// </summary>
        public static readonly string MSG_003_A = "초기화되었습니다.";

        /// <summary>
        /// 승인 선택 시 확인 메세지
        /// : 승인하시겠습니까?\n승인 시 더 이상의 수정이 불가능합니다.
        /// </summary>
        public static readonly string MSG_004_Q = "승인하시겠습니까?승인 시 더 이상의 수정이 불가능합니다.";

        /// <summary>
        /// 승인 완료 후 메세지
        /// : 승인되었습니다.
        /// </summary>
        public static readonly string MSG_004_A = "승인되었습니다.";

        /// <summary>
        /// 반려 선택 후 확인 메세지
        /// : 반려하시겠습니까?
        /// </summary>
        public static readonly string MSG_005_Q = "반려하시겠습니까?";

        /// <summary>
        /// 반려 완료 후 메세지
        /// : 반려되었습니다.
        /// </summary>
        public static readonly string MSG_005_A = "반려되었습니다.";

        /// <summary>
        /// 수정 선택 시 확인 메세지
        /// : 수정하시겠습니까?
        /// </summary>
        public static readonly string MSG_006_Q = "수정하시겠습니까?";

        /// <summary>
        /// 수정 완료 후 메세지
        /// : 수정되었습니다.
        /// </summary>
        public static readonly string MSG_006_A = "수정되었습니다.";

        /// <summary>
        /// 엑셀업로드 완료 후 메세지
        /// : 데이터가 저장되었습니다.
        /// </summary>
        public static readonly string MSG_007_A = "데이터가 저장되었습니다.";

        /// <summary>
        /// 엑셀업로드 중 오류 메세지
        /// : 엑셀 데이터에 오류가 있습니다.\n확인 후 다시 업로드해주세요
        /// </summary>
        public static readonly string MSG_007_E = "엑셀 데이터에 오류가 있습니다.확인 후 다시 업로드해주세요";
        /// <summary>
        /// 엑셀업로드 중 오류 메세지
        /// : 공시항목에 없는 데이터가있습니다.\n 확인 후 다시 업로드해주세요.
        /// </summary>
        public static readonly string MSG_007_F = "공시항목에 없는 데이터가있습니다. 확인 후 다시 업로드해주세요.";

        /// <summary>
        /// 엑셀업로드 중 엑셀 파일이 아닐때 메세지
        /// : 엑셀 파일만 업로드 가능합니다.
        /// </summary>
        public static readonly string MSG_007_C = "엑셀 파일만 업로드 가능합니다.";

        /// <summary>
        /// 계획설정 승인요청 시 확인 메세지
        /// : 설정완료 후 계획 수정이 불가능합니다.\n설정을 완료하시겠습니까?
        /// </summary>
        public static readonly string MSG_008_Q = "설정완료 후 계획 수정이 불가능합니다.설정을 완료하시겠습니까?";

        /// <summary>
        /// 설정 선택 시 확인 메세지
        /// : 설정을 완료하시겠습니까?
        /// </summary>
        public static readonly string MSG_008_W = "설정을 완료하시겠습니까?";

        /// <summary>
        /// 회사등록/수정 시 공시사용여부 및 사용년월 저장/수정시 메세지
        /// : 설정완료 후 계획 수정이 불가능합니다.\n설정을 완료하시겠습니까?
        /// </summary>
        public static readonly string MSG_008_E = "공시 사용으로 변경되었습니다.";

        /// <summary>
        /// 회사등록/수정 시 공시사용여부 및 사용년월 저장/수정시 메세지
        /// : 설정완료 후 계획 수정이 불가능합니다.\n설정을 완료하시겠습니까?
        /// </summary>
        /// 
        public static readonly string MSG_008_R = "공시 미사용으로 변경되었습니다.";

        /// <summary>
        /// 회사등록/수정 시 사용년월 저장/수정시 메세지
        /// : 설정완료 후 계획 수정이 불가능합니다.\n설정을 완료하시겠습니까?
        /// </summary>
        /// 
        public static readonly string MSG_008_T = "공시사용년월이 변경되었습니다.";
        /// <summary>
        ///  설정 완료 후 메세지
        ///  : 설정을 완료되었습니다.
        /// </summary>
        public static readonly string MSG_008_A = "설정을 완료되었습니다.";

        public static readonly string MSG_001_INT = "(은)는 숫자만 입력해주세요.";

        public static readonly string MSG_001_ALL_REJECT = "해당년월경영실적에 반려처리된 항목이 있습니다[반려처리가 된항목이 승인처리된후 통합승인이 가능합니다.]";
        public static readonly string MSG_001_ALL_READY = "해당년월경영실적에 항목중 승인되지않은 항목이 있습니다.[모든 항목이 승인완료되어야 통합승인처리됩니다]";
        public static readonly string MSG_001_ALL_SUCESS = "승인처리 되었습니다.";
    }
}