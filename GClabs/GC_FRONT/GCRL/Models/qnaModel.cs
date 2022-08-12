using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GCRL.Models
{
    public class qnaWriteModel
    {
        [Required]
        public string QUESTION_TYPE { get; set; }

        [Required]
        [StringLength(10)]
        public string ANS_TYPE { get; set; }

        [Required]
        [StringLength(30)]
        public string NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string REGION_NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string ORG_NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string DEPT_NAME { get; set; }

        [Required]
        [StringLength(11)]
        public string CONTACT { get; set; }

        [Required]
        [StringLength(100)]
        public string EMAIL { get; set; }

        [Required]
        [StringLength(10)]
        public string OCCUPATION { get; set; }

        [Required]
        [StringLength(30)]
        public string PASSWORD { get; set; }

        [Required]
        [StringLength(50)]
        public string TITLE { get; set; }

        [Required]
        public string CONTENTS { get; set; }
    }

    public class engQnaWriteModel
    {
        [Required]
        public string QUESTION_TYPE { get; set; }

        [Required]
        [StringLength(30)]
        public string NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string COUNTRY_NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string REGION_NAME { get; set; }

        [Required]
        [StringLength(50)]
        public string ORG_NAME { get; set; }

        [Required]
        [StringLength(11)]
        public string CONTACT { get; set; }

        [Required]
        [StringLength(100)]
        public string EMAIL { get; set; }

        [Required]
        [StringLength(50)]
        public string TITLE { get; set; }

        [Required]
        public string CONTENTS { get; set; }
    }

    public class qnaConfirmModel
    {
        [Required]
        [StringLength(100)]
        public string EMAIL { get; set; }

        [Required]
        [StringLength(30)]
        public string PASSWORD { get; set; }
    }

    public class qnaAuthModel : qnaConfirmModel
    {
        public string AuthDate { get; set; }
    }

    public class qnaListMode
    {
        public int IDX { get; set; }
        public string TITLE { get; set; }

        public string CONTENTS { get; set; }

        public DateTime QUESTION_DATE { get; set; }

        public string ANS_ST_NAME { get; set; }

        public string ANS_ST { get; set; }

        public string ANS_TITLE { get; set; }

        public string ANS_CONTENTS { get; set; }

        public string ATTACH1_ORG_NAME { get; set; }

        public string ATTACH1_SAVE_NAME { get; set; }

        public string ATTACH2_ORG_NAME { get; set; }

        public string ATTACH2_SAVE_NAME { get; set; }

    }
}