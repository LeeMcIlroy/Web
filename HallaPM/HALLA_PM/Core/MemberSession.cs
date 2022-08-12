using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Models;

namespace HALLA_PM.Core
{
    public class MemberSession
    {
        public InsaUserV insaUserV { get; set; }

        public InsaDeptV insaDeptV { get; set; }

        public List<LevelTwo> lv2 { get; set; }

        public List<SystemMenuAuth> systemMenuAuth { get; set; }

        public List<SystemOrgAuthExp> systemOrgAuth { get; set; }

        public List<RegistYearList> planYear { get; set; }
        public AdminAuth adminAuth { get; set; }
    }
}