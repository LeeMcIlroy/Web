using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCMaster.Modules
{
    public static class Messages
    {
        /// <summary>
        /// 시작일은 종료일 이전으로만 선택 가능합니다.
        /// </summary>
        public const string A1 = "시작일은 종료일 이전으로만 선택 가능합니다.";

        /// <summary>
        /// 시작일/종료일은 숫자로 입력 가능합니다.
        /// </summary>
        public const string A2 = "시작일/종료일은 숫자로 입력 가능합니다.";

        /// <summary>
        /// 필수항목을 입력해 주세요.
        /// </summary>
        public static string A4e(string label)
        {
            return $"{label}을(를) 입력해 주세요.";
        }

        /// <summary>
        /// 필수항목을 선택해 주세요.
        /// </summary>
        public static string A4s(string label)
        {
            return $"{label}을(를) 선택해 주세요.";
        }

        /// <summary>
        /// 수정된 내용이 없습니다.
        /// </summary>
        public const string A5 = "수정된 내용이 없습니다.";

        /// <summary>
        /// 파일형식 오류 : 파일 형식은 OO만 가능합니다.
        /// </summary>
        public const string A7 = "파일형식 오류 : 파일 형식은 OO만 가능합니다.";

        /// <summary>
        /// 파일용량 오류 : 파일 크기는 최대 20M까지 업로드 가능합니다.
        /// </summary>
        public const string A8 = "파일용량 오류 : 파일 크기는 최대 20M까지 업로드 가능합니다.";

        /// <summary>
        /// 파일용량 오류 : 이미지 파일 크기는 최대 500K까지 업로드 가능합니다.
        /// </summary>
        public const string A9 = "파일용량 오류 : 이미지 파일 크기는 최대 500K까지 업로드 가능합니다.";



        /// <summary>
        /// 게시물을 삭제 하시겠습니까?
        /// </summary>
        public const string C1 = "게시물을 삭제 하시겠습니까?";

        /// <summary>
        /// 게시물을 등록 하시겠습니까?
        /// </summary>
        public const string C2 = "게시물을 등록 하시겠습니까?";

        /// <summary>
        /// 게시물 작성을 취소 하시겠습니까?
        /// </summary>
        public const string C3 = "게시물 작성을 취소 하시겠습니까?";

        /// <summary>
        /// 게시물을 수정 하시겠습니까?
        /// </summary>
        public const string C4 = "게시물을 수정 하시겠습니까?";


        /// <summary>
        /// 게시물에 수정사항이 있습니다. 반영하지 않고 목록으로 이동하시겠습니까?
        /// </summary>
        public const string C5 = "게시물에 수정사항이 있습니다. 반영하지 않고 목록으로 이동하시겠습니까?";

        /// <summary>
        /// 삭제하시겠습니까?
        /// </summary>
        public const string C6 = "삭제 하시겠습니까?";

        /// <summary>
        /// 첨부된 파일을 삭제 하시겠습니까?
        /// </summary>
        public const string C8 = "첨부된 파일을 삭제 하시겠습니까?";

        /// <summary>
        /// 첨부된 이미지를 삭제 하시겠습니까?
        /// </summary>
        public const string C9 = "첨부된 이미지를 삭제 하시겠습니까?";

    }
}