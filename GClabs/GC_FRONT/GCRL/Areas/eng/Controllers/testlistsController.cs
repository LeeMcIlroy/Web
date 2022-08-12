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
using System.Web.UI;

namespace GCRL.Areas.eng.Controllers
{

    public class testlistsController : Controller
    {
        private readonly int _pageSize   = 10;
        // GET: eng/testlists
        public ActionResult list(itemModel form)
        {
            using (var client = new HttpClient())
            {
                string initial = Request.QueryString["initial"] ?? "";
                string field = Request.QueryString["field"] ?? "";
                string searchType = HttpUtility.UrlDecode(Request.QueryString["searchType"] ?? "");
                string searchText = HttpUtility.UrlDecode(Request.QueryString["searchText"] ?? "");

                int pageNumber = Convert.ToInt16(Request.QueryString["pageNo"] ?? "1");
                string onoff = HttpUtility.UrlDecode(Request.QueryString["onoff"] ?? "off");
                ViewBag.onoff = onoff;
                ViewBag.initial = initial == "" ? "" : (initial == "null" ? "" : initial);
                ViewBag.field = field == "" ? "" : field;

                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소
                                                                            //pageNo = 1 & pageSize = 20 &initail = &field = &searchType = &searchText = &Lng =
                                                                            //의뢰서 소견서 동의서 HTTP GET
                                                                            //var responseTask = client.GetAsync("TestingItem"); // 각 API 종류에 맞게 수정

                Task<HttpResponseMessage> responseTask = null;
                if (searchText == null || searchText == "")
                {
                    responseTask = client.GetAsync("TestingItem?pageSize=10" + "&pageNo=" + pageNumber + "&initial=" + initial + "&field=" + field + "&searchType=" + searchType + "&lng=EN"); // 각 API 종류에 맞게 수정
                }
                else
                {
                    responseTask = client.GetAsync("TestingItem?pageSize=10" + "&pageNo=" + pageNumber + "&initial=" + initial + "&field=" + field + "&searchType=" + searchType + "&searchText=" + searchText + "&lng=EN" ); // 각 API 종류에 맞게 수정
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
                    ViewBag.head = Convert.ToInt32(infovalue.count);   // 결과 카운트 

                    // 검색어가 있을경우 (받아온 JSON 파일에서 검색)
                    if (form.search != null)
                    {
                        bool checkSearch;

                        for (int i = 0; i < clientarray.Count; i++)
                        {
                            // 검색된 항목이 있는지 체크
                            checkSearch = jObject["data"][i]["itemCode"].ToString().Contains(form.search);
                            checkSearch = jObject["data"][i]["itemName"].ToString().Contains(form.search);
                            checkSearch = jObject["data"][i]["insCode"].ToString().Contains(form.search);
                            checkSearch = jObject["data"][i]["insNo"].ToString().Contains(form.search);

                            if (checkSearch.Equals(true))
                            {
                                searcharray.Add(jToken[i]);   // 검색된 항목 searcharray 목록 추가
                            }
                        }

                        // 검색된 항목으로 목록 전달
                        List<itemModel> SearchResult = searcharray.ToObject<List<itemModel>>();

                        return View(SearchResult);
                    }
                    else
                    {
                        List<itemModel> lstResult = new List<itemModel>();

                        //ViewBag.initial = initial == "" ? "All" : initial;
                        //ViewBag.field = field == "" ? "All" : field;
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

                       
                            lstResult = clientarray.ToObject<List<itemModel>>();

                            return View(lstResult.ToPagedList(1, _pageSize));
                        }
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

                var responseTask = client.GetAsync("testingItem/" + code + "?imgPath=true&lng=EN"); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;
                ViewBag.bottleNow = ViewBag.bottleCnt = 1; //검체용기 카운트

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);

                    itemViewModel lstResult = new itemViewModel();
                    JToken token = jObject["data"]["bottle"];
                    ViewBag.bottleCnt = token.Count();

                    if (token.Type == JTokenType.Null)
                    {
                        lstResult.Specimen = "";
                        lstResult.Storage =      "";
                        lstResult.Stability =    "";
                        lstResult.Method =       "";
                        lstResult.Day =          "";
                        lstResult.During = "";
                        lstResult.Caution       ="";
                        lstResult.itemName      ="";
                        lstResult.itemCode      ="";
                        lstResult.field = "";
                        if (token.Type == JTokenType.Null)
                        {
                            lstResult.name ="";
                            lstResult.additive ="";
                            lstResult.tests ="";
                            lstResult.collection ="";
                            lstResult.storage = "";
                            lstResult.method =  "";
                            lstResult.imagePath = "";
                        }
                        else
                        {

                            lstResult.name = jObject["data"]["bottle"][0]["name"].ToString();
                            lstResult.additive = jObject["data"]["bottle"][0]["additive"].ToString();
                            lstResult.tests = jObject["data"]["bottle"][0]["tests"].ToString();
                            lstResult.collection = jObject["data"]["bottle"][0]["collection"].ToString();
                            lstResult.storage = jObject["data"]["bottle"][0]["storage"].ToString();
                            lstResult.method = jObject["data"]["bottle"][0]["method"].ToString();
                            lstResult.imagePath = jObject["data"]["bottle"][0]["imagePath"].ToString();
                        
                        }
                    }
                    else
                    {
                        lstResult.Specimen =jObject["data"]["specimen"].ToString();
                        lstResult.Storage   = jObject["data"]["storage"].ToString();
                        lstResult.Stability = jObject["data"]["stability"].ToString();
                        lstResult.Method    = jObject["data"]["method"].ToString();
                        lstResult.Day       = jObject["data"]["day"].ToString();
                        lstResult.During    = jObject["data"]["during"].ToString();
                        lstResult.Meaning = jObject["data"]["meaning"].ToString();
                        lstResult.Caution = jObject["data"]["caution"].ToString();
                        lstResult.Essential = jObject["data"]["essential"].ToString();
                        lstResult.Reference = jObject["data"]["reference"].ToString();
                        lstResult.Caution   = jObject["data"]["caution"].ToString();
                        lstResult.itemName  = jObject["data"]["itemName"].ToString();
                        lstResult.itemCode  = jObject["data"]["itemCode"].ToString();
                        lstResult.field     = jObject["data"]["field"].ToString();

                    }
                    if (jObject["errorCode"].ToString().Equals("500"))
                    {
                     
                        return RedirectToAction("list");
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

                var responseTask = client.GetAsync("testingItem/" + code + "?imgPath=true&lng=EN"); // 각 API 종류에 맞게 수정
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
                    //JToken token = jObject["data"];
                    //if (token.Type == JTokenType.Null)
                    //{

                    //    lstResult.imagePath = "";
                    //    lstResult.name = "";
                    //    lstResult.additive = "";
                    //    lstResult.tests = "";
                    //    lstResult.collection = "";
                    //    lstResult.storage = "";
                    //    lstResult.method = "";

                    //}
                    //else
                    //{

                        lstResult.imagePath = jObject["data"]["bottle"][idx]["imagePath"].ToString();
                        lstResult.name = jObject["data"]["bottle"][idx]["name"].ToString();
                        lstResult.additive = jObject["data"]["bottle"][idx]["additive"].ToString();
                        lstResult.tests = jObject["data"]["bottle"][idx]["tests"].ToString().Replace("<br>", " ");
                        lstResult.collection = jObject["data"]["bottle"][idx]["collection"].ToString().Replace("<br>", " ");
                        lstResult.storage = jObject["data"]["bottle"][idx]["storage"].ToString().Replace("<br>", " ");
                        lstResult.method = jObject["data"]["bottle"][idx]["method"].ToString().Replace("<br>", " ");

                    
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