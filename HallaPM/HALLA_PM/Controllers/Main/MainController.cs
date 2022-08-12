using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;
using System.Net;
using System.IO;
using System.Text;

namespace HALLA_PM.Controllers
{
    [RoutePrefix("Main")]
    public class MainController : Controller
    {
        [SystemLoginFilter]
        [Route("Main")]
        public ActionResult Main()
        {
            RegistYearListRepo rYearListRepo = new RegistYearListRepo();
            List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            var m = registYearPm.Where(w => w.RegistYear == y.Last().RegistYear).ToList();

            // y.Last().RegistYear;
            // m.Last().RegistMonth;

            string year = DateTime.Now.Year.ToString();
            //year = y.Last().RegistYear;
            string mm = DateTime.Now.AddMonths(-1).Month.ToString().PadLeft(2, '0');
            //mm = m.Last().RegistMonth;

            PmGroupRepo pmGroupRepo = new PmGroupRepo();
            dynamic model = new ExpandoObject();
            model.list = pmGroupRepo.selectListRegist(new { }).Where(w=>w.PmYear == year).Where(w=>w.Monthly == mm).ToList();
            return View("~/Views/Main/Main.cshtml", model);
        }

        [Route("krx")]
        public string krx(string code)
        {
            string rtnValue = "";

            string url = "http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code=" + code;
            HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(string.Format(url));
            webReq.Method = "GET";
            HttpWebResponse webResponse = (HttpWebResponse)webReq.GetResponse();

            Stream answer = webResponse.GetResponseStream();
            StreamReader adswerReader = new StreamReader(answer, Encoding.UTF8);

            rtnValue = adswerReader.ReadToEnd();
            return rtnValue;
        }

        [Route("koreaexim")]
        public string koreaexim(string authkey, string searchdate, string data)
        {
            string rtnValue = "";

            string url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=" + authkey + "&searchdate=" + searchdate + "&data=" + data;
            HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(string.Format(url));
            webReq.Method = "GET";
            HttpWebResponse webResponse = (HttpWebResponse)webReq.GetResponse();

            Stream answer = webResponse.GetResponseStream();
            StreamReader adswerReader = new StreamReader(answer, Encoding.UTF8);

            rtnValue = adswerReader.ReadToEnd();
            return rtnValue;
        }

        [Route("bok")]
        public string bok(string data)
        {
            string rtnValue = "";

            string url = "http://ecos.bok.or.kr/api/" + data;
            HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(string.Format(url));
            webReq.Method = "GET";
            HttpWebResponse webResponse = (HttpWebResponse)webReq.GetResponse();

            Stream answer = webResponse.GetResponseStream();
            StreamReader adswerReader = new StreamReader(answer, Encoding.UTF8);

            rtnValue = adswerReader.ReadToEnd();
            return rtnValue;
        }
    }
}