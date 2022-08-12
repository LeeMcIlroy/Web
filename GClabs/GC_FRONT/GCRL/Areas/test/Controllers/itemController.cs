using Dapper;
using GCRL.Areas.test.Models;
using Newtonsoft.Json.Linq;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.test.Controllers
{
    public class itemController : Controller
    {
        private readonly int _pageSize = 10;

        // GET: test/item
        public ActionResult list(itemModel form)
        {
            using (var client = new HttpClient())
            {
                string initial  = Request.QueryString["initial"] ?? "";
                string field = Request.QueryString["field"] ?? "";
                string searchType = HttpUtility.UrlDecode(Request.QueryString["searchType"] ?? "");
                string searchText = HttpUtility.UrlDecode(Request.QueryString["searchText"] ?? "");
                int pageNumber = Convert.ToInt16(Request.QueryString["pageNo"] ?? "1");
                string onoff = HttpUtility.UrlDecode(Request.QueryString["onoff"] ?? "off");
                ViewBag.onoff = onoff;
              
                ViewBag.initial = initial == "" ? "" : (initial == "null" ? "" : initial);
                ViewBag.field = field == "" ? "" : field;

                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  
                // API BASE 주소
                //pageNo = 1 & pageSize = 20 &initail = &field = &searchType = &searchText = &Lng =
                //의뢰서 소견서 동의서 HTTP GET
                //var responseTask = client.GetAsync("TestingItem"); // 각 API 종류에 맞게 수정

                Task<HttpResponseMessage> responseTask = null;
                if (searchText == null || searchText == "")
                {

                    responseTask = client.GetAsync("TestingItem?pageSize=10" + "&pageNo=" + pageNumber + "&initial=" + initial + "&field=" + field + "&searchType=" + searchType); // 각 API 종류에 맞게 수정

                }
                else
                {
                    responseTask = client.GetAsync("TestingItem?pageSize=10" + "&pageNo=" + pageNumber + "&initial=" + initial + "&field=" + field + "&searchType=" + searchType + "&searchText=" + searchText); // 각 API 종류에 맞게 수정
                }

               

                responseTask.Wait();

                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);
                    JToken jToken = jObject["data"];
                    var clientarray = jObject["data"].Value<JArray>();
                    var searcharray = new JArray();
                    var infovalue = new itemModel();
                    infovalue.count = jObject["totalCount"].ToString();
                    var tmp = Convert.ToInt32(infovalue.count);
                    ViewBag.head = tmp;   // 결과 카운트 

                   
                    List<itemModel> lstResult = new List<itemModel>();

                    ViewBag.searchType = searchType == "" ? "" : searchType;
                    ViewBag.searchText = searchText == "" ? "" : searchText;

                    if (clientarray == null)
                    {
                        ModelState.AddModelError(string.Empty, "데이터가없습니다.");

                        return View(lstResult.ToPagedList(pageNumber, _pageSize));
                    }
                    else
                    {
                        ViewBag.pageNo = pageNumber;
                        ViewBag.pageSize = 10;

                        // JSON 전체 항목 전달
                        //ViewBag.test = lstResult;
                        lstResult = clientarray.ToObject<List<itemModel>>();

                        return View(lstResult.ToPagedList(1, _pageSize));
                    }

                }
                else //web api sent error response 
                {

                    ModelState.AddModelError(string.Empty, "서버에러. 관리자에게 문의하세요.");

                    return View();
                }
             
            }

        }

        public ActionResult view(string code)
        {
            if (code == null)
                return RedirectToAction("list");

            itemViewModel viewData = new itemViewModel();

            ViewBag.Code = code;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소

                var responseTask = client.GetAsync("testingItem/" + code + "?imgPath=true&lng=KO"); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;

                ViewBag.bottleNow = ViewBag.bottleCnt = 1; //검체용기 카운트

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);
                    itemViewModel lstResult = new itemViewModel();
                    lstResult.Specimen = jObject["data"]["specimen"].ToString().Replace("\n", "<br />");
                    lstResult.Storage = jObject["data"]["storage"].ToString();
                    lstResult.Stability = jObject["data"]["stability"].ToString();
                    lstResult.Method = jObject["data"]["method"].ToString();
                    lstResult.Day = jObject["data"]["day"].ToString();
                    lstResult.During = jObject["data"]["during"].ToString();
                    //lstResult.Price = jObject["data"]["price"].ToString();
                    JToken token1 = jObject["data"]["price"];

                    if (token1.Type != JTokenType.Null)
                    {

                        lstResult.Price = string.Format("{0:#,###}", Convert.ToInt32(jObject["data"]["price"].ToString()));
                    }
                    else { lstResult.Price = "문의요망"; }
                    
                    lstResult.Meaning = jObject["data"]["meaning"].ToString().Replace("\n", "<br />");
                    lstResult.Caution = jObject["data"]["caution"].ToString().Replace("\n", "<br />");
                    lstResult.Essential = jObject["data"]["essential"].ToString().Replace("\n", "<br />");
                    lstResult.Reference = jObject["data"]["reference"].ToString().Replace("\n", "<br />");

                    lstResult.itemName = jObject["data"]["itemName"].ToString().Replace("\n", "<br />");
                    lstResult.itemCode = jObject["data"]["itemCode"].ToString().Replace("\n", "<br />");
                    lstResult.field = jObject["data"]["field"].ToString().Replace("\n", "<br />");
                    lstResult.insCode = jObject["data"]["insCode"].ToString().Replace("\n", "<br />");
                    lstResult.insNo = jObject["data"]["insNo"].ToString().Replace("\n", "<br />");



                    JToken token = jObject["data"]["bottle"];
                    ViewBag.bottleCnt = token.Count();

                    if (token.Type == JTokenType.Null)
                    {
                        lstResult.imagePath = "";
                        lstResult.name = "";
                        lstResult.additive = "";
                        lstResult.tests = "";
                        lstResult.collection = "";
                        lstResult.storage = "";
                        lstResult.method = "";
                    }
                    else
                    {
                        lstResult.imagePath = jObject["data"]["bottle"][0]["imagePath"].ToString();
                        lstResult.name = jObject["data"]["bottle"][0]["name"].ToString();
                        lstResult.additive = jObject["data"]["bottle"][0]["additive"].ToString();
                        lstResult.tests = jObject["data"]["bottle"][0]["tests"].ToString().Replace("<br>", "<br />");                   
                        lstResult.collection = jObject["data"]["bottle"][0]["collection"].ToString().Replace("<br>", "<br />");
                        lstResult.storage = jObject["data"]["bottle"][0]["storage"].ToString().Replace("<br>", "<br />");
                        lstResult.method = jObject["data"]["bottle"][0]["method"].ToString().Replace("<br>", "<br />");
                    
                    }
                    
                    return View(lstResult);   
                }
                else //web api sent error response 
                {

                    ModelState.AddModelError(string.Empty, "서버에러. 관리자에게 문의하세요.");

                    return View();
                }
            }

        }

        public ActionResult view_bottle(string code, int idx)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소

                var responseTask = client.GetAsync("testingItem/" + code + "?imgPath=true&lng=KO"); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;

                ViewBag.bottleNow = idx;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);

                    if (jObject["data"].HasValues == false)
                    {
                        return Json(false, JsonRequestBehavior.AllowGet);
                    }

                    itemViewModel lstResult = new itemViewModel();
                    lstResult.imagePath = jObject["data"]["bottle"][idx]["imagePath"].ToString();
                    lstResult.name = jObject["data"]["bottle"][idx]["name"].ToString();
                    lstResult.additive = jObject["data"]["bottle"][idx]["additive"].ToString();
                    lstResult.tests = jObject["data"]["bottle"][idx]["tests"].ToString().Replace("<br>", "<br />");
                    lstResult.collection = jObject["data"]["bottle"][idx]["collection"].ToString().Replace("<br>", "<br />");
                    lstResult.storage = jObject["data"]["bottle"][idx]["storage"].ToString().Replace("<br>", "<br />");
                    lstResult.method = jObject["data"]["bottle"][idx]["method"].ToString().Replace("<br>", "<br />");

                    return Json(lstResult, JsonRequestBehavior.AllowGet);
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