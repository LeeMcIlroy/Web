using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Models;

namespace HALLA_PM.Core
{
    public class AdminSession
    {
        public InsaUserV insaUserV { get; set; }
        public AdminAuth adminAuth { get; set; }
        public InsaDeptV insaDeptV { get; set; }

        /// <summary>
        /// 주한라 권한 여부 체크
        /// </summary>
        public int orgCount { get; set; }
    }
}