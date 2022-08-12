using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    public class UserSearchModel : SearchModel
    {
        /// <summary>
        /// 프로필 인증 상태
        /// </summary>
        public string CertState { set; get; }

        /// <summary>
        /// 그룹
        /// </summary>
        public string GroupCode { set; get; }

        public override void SetSort()
        {
            InnerSortType = "REG_DT";
        }
    }
}
