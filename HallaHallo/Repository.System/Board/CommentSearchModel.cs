using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace HallaTube
{
    public class CommentSearchModel : SearchModel
    {
        public CommentSearchModel()
        {
            PageSize = 5;
        }

        public string ArticleID { set; get; }

        public override void SetSort()
        {
            base.SetSort();

        }

    }
}
