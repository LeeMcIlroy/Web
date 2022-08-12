using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace HallaTube
{
    [EmptyModel]
    public class PageEntity : DataEntity
    {
        /// <summary>
        /// 조회된 전체 건수
        /// </summary>
        public long TotalCount { set; get; }

        /// <summary>
        /// 한페이지에 출력될 건수
        /// </summary>
        public int PageSize { set; get; }

        /// <summary>
        /// 현재 페이지
        /// </summary>
        public int PageNumber { set; get; }

        /// <summary>
        /// 페이지 번호 선택시 실행될 자바스크립트 변수
        /// </summary>
        public string PageFunction { set; get; }

        public PageEntity()
        {
            this.TotalCount = 0;
            this.PageSize = 20;
            this.PageNumber = 1;
        }
    }
}
