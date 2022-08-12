using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GCMaster.Models
{
    public class LoginModel
    {
        [Required]
        [Display(Name = "LoginID")]
        public string LoginID { get; set; }

        [Required]
        [Display(Name = "Password")]
        public string Password { get; set; }


        [Display(Name = "아이디 저장")]
        public bool RememberID { get; set; }

        [Display(Name = "비밀번호 저장")]
        public bool RememberPWD { get; set; }
    }
}