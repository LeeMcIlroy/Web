using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Model
{
    public class equipmentModel
    {
        public string TITLE { get; set; }

        public string PURPOSE { get; set; }

        public string IMAGE_NAME { get; set; }

        public int PREV_IDX { get; set; }

        public int NEXT_IDX { get; set; }
    }
}