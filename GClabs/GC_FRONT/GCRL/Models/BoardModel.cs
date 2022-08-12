using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace GCRL.Models.Board
{
    public class CommonBoardModel
    {
        [Required]
        public int IDX { get; set; }


        public string CATEGORY { get; set; }

        /// <summary>
        /// 노출여부
        /// </summary>
        public bool USE_YN { get; set; }

        /// <summary>
        /// 공지여부
        /// </summary>
        public bool NOTI_YN { get; set; }

        /// <summary>
        /// 제목
        /// </summary>
        [StringLength(250, MinimumLength = 1)]
        public string SUBJECT { get; set; }

        /// <summary>
        /// 내용
        /// </summary>
        public string CONTENT { get; set; }

        /// <summary>
        /// 첨부파일 원본명
        /// </summary>
        [StringLength(255)]
        public string ATTATCH_ORG_NAME { get; set; }

        /// <summary>
        /// 첨부파일 저장명
        /// </summary>
        [StringLength(255)]
        public string ATTATCH_SAVE_NAME { get; set; }

        /// <summary>
        /// 첨부파일 크기
        /// </summary>
        public int ATTATCH_SIZE { get; set; }

        /// <summary>
        /// 조회수
        /// </summary>
        public int VIEW_COUNT { get; set; }

        /// <summary>
        /// 다운로드 수
        /// </summary>
        public int DOWNLOAD_COUNT { get; set; }

        /// <summary>
        /// 등록일
        /// </summary>
        public string REGDATE { get; set; }

        /// <summary>
        /// 등록자 아이디
        /// </summary>
        public string REGID { get; set; }

        /// <summary>
        /// 등록자 이름
        /// </summary>
        public string REGNAME { get; set; }

    }
}