using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class LevelOne
    {
        //public string period { get; set; }
        public Period period { get; set; }

        public List<LevelTwo> level { get; set; }
    }
}