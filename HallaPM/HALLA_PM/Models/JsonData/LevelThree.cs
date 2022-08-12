using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class LevelThree
    {
        public string UpId { get; set; }
        public string id { get; set; }
        public string txt { get; set; }

        public List<LevelFour> sub { get; set; }
    }
}