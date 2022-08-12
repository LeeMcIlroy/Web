using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace HallaTube
{
    public class ArticleSearchModel : SearchModel
    {
        /// <summary>
        /// 게시판 코드
        /// </summary>
        public string BoardCode { set; get; }

        /// <summary>
        /// 카테고리
        /// </summary>
        public string CategoryCode { set; get; }

        public string Carousel { set; get; }
        public string Hot { set; get; }

        public override void SetSort()
        {
            base.SetSort();

            if (SortType == "ArticleID")
            {
                InnerSortType = "ARTICLE_ID";
            }
            else if (SortType == "Title")
            {
                InnerSortType = "TITLE";
            }
            else if (SortType == "RegDate")
            {
                InnerSortType = "REG_DATE";
            }
            else if (SortType == "ViewCount")
            {
                InnerSortType = "VIEW_COUNT";
                SortOrd = "DESC";
            }
            else if (SortType == "LikeCount")
            {
                InnerSortType = "LIKE_COUNT";
                SortOrd = "DESC";
            }
        }
    }
}
