

using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using GCRL.Modules;
using GCRL.Model;

using Dapper;

namespace GCRL.Areas.dept.Controllers
{
    public class detailController : Controller
    {
        // GET: test/allergen
        public ActionResult ethics()
        {
        
            return View();
        }

        public ActionResult infect()
        {

            return View();
        }
        public ActionResult medicine()
        {

            return View();
        }
        public ActionResult work()
        {

            return View();
        }
        public ActionResult pathology()
        {

            return View();
        }
        public ActionResult region()
        {

            return View();
        }

        public ActionResult equipment(int idx, string code, string pcd)
        {
            string type = PageEnum.TestEquipment.ToCode();

            equipmentModel result = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                result = conn.QueryFirstOrDefault<equipmentModel>("dbo.GCRL_DEPT_EQUIPMENT_SEL",
                    param: new
                    {
                        pType = type,
                        pIDX = idx,
                        pCode = code,
                        pCommPcd = pcd
                    },
                    commandType: CommandType.StoredProcedure
                );
            }

            if (result == null)
                result = new equipmentModel()
                {
                    TITLE = "",
                    PURPOSE = "",
                    IMAGE_NAME = "",
                    PREV_IDX = 0,
                    NEXT_IDX = 0
                };

            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}