using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Controllers;
using GCRL.Models;

using Dapper;
using PagedList;


namespace GCRL.Areas.support.Controllers
{
    public class certifyController : Controller
    {
        //private readonly int _pageSize = 5;

        private readonly string _pageType = PageEnum.SupportCertify.ToCode();

        public ActionResult list()
        {

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");

            certifyListModel certifyList = new certifyListModel();
            List<certifyBoardModel> lstResult = new List<certifyBoardModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<certifyBoardModel>("dbo.GCRL_SUPPORT_CERTIFY_LIST_SEL",
                    param: new
                    {
                        pType = _pageType
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            certifyList.localCertifies = lstResult.Where(w => w.CATEGORY_CODE == "01").ToList();
            certifyList.globalCertifies = lstResult.Where(w => w.CATEGORY_CODE == "02").ToList();

            return View(certifyList);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filesname">File Saved Name</param>
        /// <param name="fileoname">File Original Name</param>
        /// <returns></returns>
        /// <exception cref="ArgumentNullException"></exception>
        public FileResult download(string filesname, string fileoname)
        {
            if (filesname == null)
                throw new ArgumentNullException("filesname");

            if (fileoname == null || fileoname == "")
                fileoname = filesname;

            byte[] fileBytes = Functions.GetFileBytes(filesname);

            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileoname);

        }
    }
}