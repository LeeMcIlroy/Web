using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Net.Http;
using System.Threading.Tasks;

using GCRL.Modules;
using GCRL.Areas.main.Models;
using GCRL.Areas.test.Models;

using Dapper;
using Newtonsoft.Json.Linq;

namespace GCRL.Areas.main.Controllers
{
    public class searchController : Controller
    {
        // GET: main/search
        public ActionResult list()
        {
            searchResultModel searchResult = new searchResultModel();

            string keyword = HttpUtility.UrlDecode(Request.QueryString["searchkeyword"] ?? "");


            ViewBag.searchkeyword = keyword;

            if (string.IsNullOrEmpty(keyword) || keyword.Length < 2)
                return View(searchResult);



            List<searchModel> lstResult = new List<searchModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<searchModel>("dbo.GCRL_MAIN_SEARCH_LIST_SEL",
                    param: new
                    {
                        pKeyWord = keyword,
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            lstResult.AddRange(getTestItem(keyword));


            

            if (lstResult != null && lstResult.Any())
            {
                foreach (var item in lstResult)
                {
                    searchResult.totalCount++;

                    switch (item.TYPE)
                    {
                        // 검사안내
                        case "006":
                            searchResult.testCount++;
                            searchResult.testList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "검사항목",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "item", new { Area = "test", @code = item.CODE })
                            });
                            break;
                        case "007":
                            searchResult.testCount++;
                            searchResult.testList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "알러지항원",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "allergen", new { Area = "test", @keyword = keyword })
                            });
                            break;
                        case "008":
                            searchResult.testCount++;
                            searchResult.testList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "질환별 패널검사",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "panel", new { Area = "test", @keyword = keyword })
                            });
                            break;
                        case "009":
                            searchResult.testCount++;
                            searchResult.testList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "종합검진 패널검사",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list2", "panel", new { Area = "test", @keyword = keyword })
                            });
                            break;

                        // 고객지원(support)

                        case "021":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "GC Labs 공문",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "official", new { Area = "support", id = item.IDX })
                            });
                            break;
                        case "022":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "학술자료 > 신규검사",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "new", new { Area = "support", @keyword = keyword })
                            });
                            break;
                        case "023":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "학술자료 > I&T",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "info", new { Area = "support", @keyword = keyword })
                            });
                            break;
                        //case "024":
                        //    searchResult.supportCount++;
                        //    if (item.ROW_NO <= 3)
                        //    {
                        //        searchResult.supportList.Add(new searchListModel()
                        //        {
                        //            IDX = item.IDX,
                        //            MENU = "인증현황",
                        //            TITLE = item.TITLE,
                        //            LINK = Url.Action("view", "certify", new { Area = "support", id = item.IDX })
                        //        });
                        //    }
                        //    break;
                        case "025":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "검사방법 약어",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "wording", new { Area = "support", @keyword = keyword })
                            });
                            break;
                        case "026":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "학술자료 > 브로슈어",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "brochure", new { Area = "support", @keyword = keyword })
                            });
                            break;
                        case "027":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "학술발표",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "announce", new { Area = "support", @keyword = keyword })
                            });
                            break;
                        case "032":
                            searchResult.supportCount++;
                            searchResult.supportList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "고객문의 > 자주하는질문",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "faq", new { Area = "support", @keyword = keyword })
                            });
                            break;

                        // 재단홍보(pr)

                        case "041":
                            searchResult.prCount++;
                            searchResult.prList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "언론보도",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "press", new { Area = "pr", id = item.IDX })
                            });
                            break;
                        case "042":
                            searchResult.prCount++;
                            searchResult.prList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "LIVE GC Labs",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "live", new { Area = "pr", id = item.IDX })
                            });
                            break;
                        case "043":
                            searchResult.prCount++;
                            searchResult.prList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "재단소식",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "news", new { Area = "pr", id = item.IDX })
                            });
                            break;
                        case "044":
                            searchResult.prCount++;
                            searchResult.prList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "홍보영상",
                                TITLE = item.TITLE,
                                LINK = Url.Action("list", "video", new { Area = "pr", @keyword = keyword })
                            });
                            break;
                        case "045":
                            searchResult.prCount++;
                            searchResult.prList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "사회공헌",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "social", new { Area = "pr", id = item.IDX })
                            });
                            break;


                        case "051":
                            searchResult.gclabsCount++;
                            searchResult.gclabsList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "전문의",
                                TITLE = item.TITLE,
                                LINK = Url.Action("view", "doctors", new { Area = "gclabs", id = item.IDX })
                            });
                            break;
                        case "052":
                            searchResult.gclabsCount++;
                            searchResult.gclabsList.Add(new searchListModel()
                            {
                                IDX = item.IDX,
                                MENU = "네트워크",
                                TITLE = item.TITLE,
                                LINK = Url.Action("network", "network", new { Area = "gclabs", @branchname = keyword })
                            });
                            break;
                        default:
                            break;
                    }
                }
            }


            return View(searchResult);
        }

        private List<searchModel> getTestItem(string mainkeyword)
        {
            List<searchModel> lstResult = new List<searchModel>();
            List<itemModel> lstItems = null;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://info.gclabs.co.kr/");

                Task<HttpResponseMessage> responseTask = client.GetAsync("TestingItem?pageSize=10&pageNo=1&initial=&field=&searchType=전체&searchText=" + mainkeyword);

                responseTask.Wait();

                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();

                    JObject jObject = JObject.Parse(readTask.Result);
                    var clientarray = jObject["data"].Value<JArray>();

                    if (clientarray != null)
                        lstItems = clientarray.ToObject<List<itemModel>>();
                }
            }

            if (lstItems != null && lstItems.Any())
            {
                lstResult = lstItems.Select(s => new searchModel
                {
                    TYPE = "006",
                    ROW_NO = Convert.ToInt32(s.no),
                    IDX = Convert.ToInt32(s.no),
                    TITLE = s.itemName,
                    CODE = s.itemCode
                }).ToList();
            }


            return lstResult;
        }
    }
}