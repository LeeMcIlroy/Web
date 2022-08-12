using GCRL.Areas.test.Models;
using Newtonsoft.Json.Linq;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.test.Controllers
{
    public class instrumentController : Controller
    {
        private readonly int _pageSize = 9;

        // GET: test/instrument
        public ActionResult list(instrumentModel form)
        {
            using (var client = new HttpClient())
            {
                string initial = Request.QueryString["initial"] ?? "";
                string field = Request.QueryString["field"] ?? "";
                string searchType = HttpUtility.UrlDecode(Request.QueryString["searchType"] ?? "");
                string searchText = HttpUtility.UrlDecode(Request.QueryString["searchText"] ?? "");
                int pageNumber = Convert.ToInt16(Request.QueryString["pageNo"] ?? "1");

                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소
   
                Task<HttpResponseMessage> responseTask = null;
                Task<HttpResponseMessage> responseTaskInit = null;

                if (searchText == null || searchText == "")
                {
                    responseTask = client.GetAsync("SpecimenCollection?pageSize=1000" +"&initial=" + initial); // 각 API 종류에 맞게 수정
                }
                else
                {
                    responseTask = client.GetAsync("SpecimenCollection?pageSize=1000" +"&initial=" + initial + "&searchType=" + searchType + "&searchText=" + searchText); // 각 API 종류에 맞게 수정
                }

                #region  초성 검색시 결과가 없는항목들 처리
                var initialarray = new JArray();

                for (int i = 65; i <= 92; i++)
                    {
                        
                        var val = string.Concat((char)i);
                        responseTaskInit = client.GetAsync("SpecimenCollection?pageSize=1000" + "&initial=" + val);
                        responseTaskInit.Wait();

                        var resultInit = responseTaskInit.Result;

                        if (resultInit.IsSuccessStatusCode)
                        {
                        var readTask = resultInit.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴
                        JObject jObjectInitial = JObject.Parse(readTask.Result);
                        JToken jTokenInitial = jObjectInitial["data"];

                        if (jTokenInitial.Type == JTokenType.Null)
                        {

                            initialarray.Add("false");
                        }
                        else
                        {
                            initialarray.Add("true");

                        }
                        // 검색된 항목으로 ViewBag.initRs 전달
                        ViewBag.initRs = initialarray;
                    }

                }
                #endregion

                responseTask.Wait();
                var result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();  // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);
                    JToken jToken = jObject["data"];
                    var clientarray = jObject["data"].Value<JArray>();
                    var infovalue = new instrumentModel();
                    infovalue.count = jObject["totalCount"].ToString();
           
                    ViewBag.totalCount = infovalue;   // 결과 카운트 

                    List<instrumentModel> lstResult = new List<instrumentModel>();

                    if (clientarray == null)
                    {
                        ModelState.AddModelError(string.Empty, "데이터가없습니다.");

                        return View(lstResult.ToPagedList(pageNumber, _pageSize));
                    }
                    else
                    {
                        ViewBag.pageNo = pageNumber;
                        ViewBag.pageSize = 9;
                        ViewBag.initial = initial == "" ? "" : initial;
                        ViewBag.searchText = searchText == "" ? "" : searchText;

                        // JSON 전체 항목 전달
                        lstResult = clientarray.ToObject<List<instrumentModel>>();
                        return View(lstResult.ToPagedList(pageNumber, _pageSize));
                    }
                   
                 
                }
                else //web api sent error response 
                {

                    ModelState.AddModelError(string.Empty, "서버에러. 관리자에게 문의하세요.");

                    return View();
                }
            }

        }

        public ActionResult view(int idx)
        {
            if (idx == 0)
                return RedirectToAction("list");

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소

                var responseTask = client.GetAsync("SpecimenCollection/" + idx); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴
                    JObject jObject = JObject.Parse(readTask.Result);

                    if (jObject["data"].HasValues ==false )
                    {
                        return Json(false, JsonRequestBehavior.AllowGet);
                    }

                    instrumentViewModel lstResult = new instrumentViewModel();

                    lstResult.name = jObject["data"]["name"].ToString();
                    lstResult.additive = jObject["data"]["additive"].ToString();
                    lstResult.tests = jObject["data"]["tests"].ToString();
                    lstResult.collection = jObject["data"]["collection"].ToString();
                    lstResult.storage = jObject["data"]["storage"].ToString();
                    lstResult.method = jObject["data"]["method"].ToString();
                    lstResult.imagePath = jObject["data"]["imagePath"].ToString();
                    lstResult.pre_idx = jObject["data"]["pre_idx"].ToString();
                    lstResult.next_idx = jObject["data"]["next_idx"].ToString();
                    return Json(lstResult , JsonRequestBehavior.AllowGet);
         
                }
                else //web api sent error response 
                {

                    ModelState.AddModelError(string.Empty, "서버에러. 관리자에게 문의하세요.");

                    return View();
                }
            }

        }
    }
}