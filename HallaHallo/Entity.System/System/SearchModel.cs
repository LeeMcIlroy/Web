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
    public class SearchModel:DataModel
    {
        public SearchModel()
        {
            StartDate = DateTime.UtcNow.AddYears(-1).AddHours(9);

            EndDate = DateTime.UtcNow.AddHours(9);
        }
        
        /// <summary>
        /// 정렬 형태
        /// </summary>
        public string SortType { set; get; }
        [ReflectionType("NoUserInput")]
        public string InnerSortType { set; get; }

        /// <summary>
        /// 정렬 방향
        /// </summary>
        [DefaultValue("DESC")]
        public string SortOrd { set; get; }

        /// <summary>
        /// 사용자ID
        /// </summary>
        [ReflectionType("NoUserInput")]
        public string UserID { set; get; }

        /// <summary>
        /// 검색 영역
        /// </summary>
        public string Area { set; get; }

        /// <summary>
        /// 검색어
        /// </summary>
        public string Word { set; get; }

        /// <summary>
        /// 상태
        /// </summary>
        public string State { set; get; }

        /// <summary>
        /// 페이지당 출력될 목록 건수
        /// </summary>
        [DefaultValue(Const.LIST_PAGE_SIZE)]
        public int PageSize { set; get; }

        /// <summary>
        /// 현재 페이지
        /// </summary>
        [DefaultValue(1)]
        public int PageNumber { set; get; }

        /// <summary>
        /// 전체건수
        /// </summary>
        [ReflectionType("NoUserInput")]
        public long TotalCount { set; get; }


        /// 검색날짜 타입
        public string DateType { set; get; }

        /// <summary>
        /// 날짜 검색 시작일
        /// </summary>
        [SQLDataType(SqlDbType.DateTime)]
        public DateTime StartDate { set; get; }

        /// <summary>
        /// 날짜 검색 종료일
        /// </summary>
        [SQLDataType(SqlDbType.DateTime)]
        public DateTime EndDate { set; get; }

        /// <summary>
        /// 이전, 다음위치 검색에 사용될 기준아이디
        /// </summary>
        [ReflectionType("NoUserInput")]
        public string PointID { set; get; }

        /// <summary>
        /// 방향
        /// </summary>
        [ReflectionType("NoUserInput")]
        [DefaultValue(Const.PointNext)]
        public string PointOrd { set; get; }

        /// <summary>
        /// 엑셀 다운로드 여부
        /// </summary>
        [DefaultValue(Const.False)]
        public string UseExcel { set; get; }

        /// <summary>
        /// 페이지 네이게이터 개체 반환
        /// </summary>
        /// <returns></returns>
        public PageEntity getPageEntity()
        {
            // 결과값 셋팅
            var pageEntity = new PageEntity();
            pageEntity.PageNumber = this.PageNumber;
            pageEntity.PageSize = this.PageSize;
            pageEntity.TotalCount = this.TotalCount;

            return pageEntity;
        }

        /// <summary>
        /// 정렬 설정
        /// </summary>
        public virtual void SetSort()
        {
            if (string.IsNullOrEmpty(SortType))
            {
                this.SortType = "RegDate";
                SortOrd = "DESC";
            }

            if (SortType == "RegDate")
            {
                InnerSortType = "REG_DATE";
            }

            if (this.SortOrd.ToUpper() == "DESC")
            {
                this.SortOrd = "DESC";
            }
            else
            {
                this.SortOrd = "ASC";
            }
        }

        /// <summary>
        /// 정렬 설정 (필독에 따름)
        /// </summary>
        public virtual void SetSortByNotice()
        {
            //if (string.IsNullOrEmpty(SortType))
            //{
            //    this.SortType = "CreateDate";
            //}

            //if (SortType == "CreateDate")
            //{
            //    InnerSortType = "CREATE_DATE";
            //}

            //if (this.SortOrd.ToUpper() == "DESC")
            //{
            //    this.SortOrd = "DESC";
            //}
            //else
            //{
            //    this.SortOrd = "ASC";
            //}
            InnerSortType = "CHARINDEX(STATE, 'Notice') DESC, CREATE_DATE";
            this.SortOrd = "DESC";
        }
    }
}
