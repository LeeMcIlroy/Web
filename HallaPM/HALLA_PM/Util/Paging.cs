using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Util
{
    public class Paging
    {
        #region DEFAULT_PAGING_INDEX : 페이지의 처음 시작값(디폴트)입니다.
        /// <summary>
        /// 페이지의 처음 시작값(디폴트)입니다.
        /// </summary>
        private readonly int DEFAULT_PAGING_INDEX = 1;
        #endregion

        #region DEFAULT_PAGING_SIZE : 페이지의 사이즈입니다.
        /// <summary>
        /// 페이지의 사이즈입니다.
        /// </summary>
        private readonly int DEFAULT_PAGING_SIZE = 10;
        #endregion

        #region DEFAULT_PAGING_COUNT : 한 페이지 당 게시물의 숫자입니다.
        /// <summary>
        /// 한 페이지 당 게시물의 숫자입니다.
        /// </summary>
        private readonly int DEFAULT_PAGING_COUNT = 10;
        #endregion

        #region 변수선언
        public int PageCount { get; set; } = 0;
        public int PageSize { get; set; } = 0;
        public int FirstPageIndex { get; set; }
        public int PrevPageIndex { get; set; }
        public int StartPageIndex { get; set; }
        public int PageIndex { get; set; }
        public int EndPageIndex { get; set; }
        public int NextPageIndex { get; set; }
        public int FinalPageIndex { get; set; }
        public int TotalCount { get; set; }
        #endregion

        #region MakePaging : 페이지를 만듭니다.
        /// <summary>
        /// 페이지를 만듭니다.
        /// </summary>
        public void MakePaging()
        {
            if (PageCount == 0) PageCount = DEFAULT_PAGING_COUNT;
            if (PageIndex == 0) PageIndex = DEFAULT_PAGING_INDEX;
            if (PageSize == 0) PageSize = DEFAULT_PAGING_SIZE;
            if (TotalCount == 0) return;

            int finalPage = (TotalCount + (PageCount - 1)) / PageCount;
            if (PageIndex > finalPage) PageIndex = finalPage;
            if (PageIndex < 0 || PageIndex > finalPage) PageIndex = 1;

            bool isIndexFirst = PageIndex == 1 ? true : false;
            bool isIndexFinal = PageIndex == finalPage ? true : false;

            int startPage = ((PageIndex - 1) / PageSize) * PageSize + 1;
            int endPage = startPage + PageSize - 1;

            if (endPage > finalPage) endPage = finalPage;

            FirstPageIndex = 1;

            if (isIndexFirst)
            {
                PrevPageIndex = 1;
            }
            else
            {
                PrevPageIndex = (((PageIndex - 1) < 1 ? 1 : (PageIndex - 1)));
            }

            StartPageIndex = startPage;
            EndPageIndex = endPage;

            if (isIndexFinal)
            {
                NextPageIndex = finalPage;
            }
            else
            {
                NextPageIndex = (((PageIndex + 1) > finalPage ? finalPage : (PageIndex + 1)));
            }

            FinalPageIndex = finalPage;
        }
        #endregion
    }
}