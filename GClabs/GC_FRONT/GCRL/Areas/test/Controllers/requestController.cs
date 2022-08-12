using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Net.Http;
using GCRL.Controllers;
using System.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using GCRL.Areas.test.Models;

namespace GCRL.Areas.test.Controllers
{
    public class requestController : BaseController
    {
        // GET: test/request
        
        public ActionResult list(requestModel form)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);  // API BASE 주소
                // 자주찾는 문서 4 개
                var visit = new requestModel();

                //의뢰서 소견서 동의서 HTTP GET
                var responseTask = client.GetAsync("RequestFile?pageNo=1&pageSize=50&includeFile=false"); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();      // 직열화 로 JSON 파일 갖고옴

                    JObject jObject = JObject.Parse(readTask.Result);
                    JToken jToken = jObject["data"];
                    //JArray jArray = (JArray)jObject["data"];

                    var clientarray = jObject["data"].Value<JArray>();
                    var searcharray = new JArray();
                    var infovalue = new requestModel();

                    int rank = 1;

                    for (int y = 0; y < clientarray.Count; y++)
                    {
                        jObject["data"][y]["idx"] = y + 1; // 인덱스 변경

                        // 많이 조회된 순위 구하기
                        for(int t = 0; t < clientarray.Count; t++)
                        {
                            if (Int32.Parse(jObject["data"][y]["viewOrderby"].ToString()) < Int32.Parse(jObject["data"][t]["viewOrderby"].ToString()))
                            {
                                rank++;
                            }
                        }
                            if(rank == 1)
                            {
                                //ViewBag.viewOrderbylist +="/" + jObject["data"][y]["viewOrderby"];
                                visit.load_idx1 = jObject["data"][y]["idx"].ToString();
                                visit.idx1 = jObject["data"][y]["idx"].ToString();
                                visit.name1 = jObject["data"][y]["name"].ToString();
                                visit.fileName1 = jObject["data"][y]["fileName"].ToString();
                                visit.jpgFile1 = jObject["data"][y]["jpgFile"].ToString();
                            }

                            if (rank == 2)
                            {
                                visit.load_idx2 = jObject["data"][y]["idx"].ToString();
                                visit.idx2 = jObject["data"][y]["idx"].ToString();
                                visit.name2 = jObject["data"][y]["name"].ToString();
                                visit.fileName2 = jObject["data"][y]["fileName"].ToString();
                                visit.jpgFile2 = jObject["data"][y]["jpgFile"].ToString();
                            }

                            if (rank == 3)
                            {
                                visit.load_idx3 = jObject["data"][y]["idx"].ToString();
                                visit.idx3 = jObject["data"][y]["idx"].ToString();
                                visit.name3 = jObject["data"][y]["name"].ToString();
                                visit.fileName3 = jObject["data"][y]["fileName"].ToString();
                                visit.jpgFile3 = jObject["data"][y]["jpgFile"].ToString();
                            }

                            if (rank == 4)
                            {
                                visit.load_idx4 = jObject["data"][y]["idx"].ToString();
                                visit.idx4 = jObject["data"][y]["idx"].ToString();
                                visit.name4 = jObject["data"][y]["name"].ToString();
                                visit.fileName4 = jObject["data"][y]["fileName"].ToString();
                                visit.jpgFile4 = jObject["data"][y]["jpgFile"].ToString();
                            }

                            if (rank == 5)
                            {
                                visit.load_idx5 = jObject["data"][y]["idx"].ToString();
                                visit.idx5 = jObject["data"][y]["idx"].ToString();
                                visit.name5 = jObject["data"][y]["name"].ToString();
                                visit.fileName5 = jObject["data"][y]["fileName"].ToString();
                                visit.jpgFile5 = jObject["data"][y]["jpgFile"].ToString();
                            }
                        rank = 1;
                    }

                    ViewBag.visit = visit;

                    // 검색어가 있을경우 (받아온 JSON 파일에서 검색)
                    if (form.search != null)
                    {
                        bool checkSearch;

                        for (int i=0; i < clientarray.Count; i++)
                        {
                            // 검색된 항목이 있는지 체크
                            checkSearch = jObject["data"][i]["name"].ToString().Contains(form.search);

                            if(checkSearch.Equals(true))
                            {
                                //jObject["data"][i]["idx"] = i+1; // 인덱스 변경
                                searcharray.Add(jToken[i]);   // 검색된 항목 searcharray 목록 추가
                            }
                        }

                        // 검색된 항목으로 목록 전달
                        List<requestModel> SearchResult = searcharray.ToObject<List<requestModel>>();
                        ViewBag.test = SearchResult;

                        infovalue.count = searcharray.Count.ToString();   // 검색결과 카운트 
                        ViewBag.head = infovalue;   // 결과 카운트 
                        ViewBag.search = form.search;
                        return View(SearchResult);
                    }
                    else
                    {
                        // JSON 전체 항목 전달
                        List<requestModel> lstResult = clientarray.ToObject<List<requestModel>>();
                        ViewBag.test = lstResult;

                        infovalue.count = jObject["count"].ToString(); // 전체 카운트
                        ViewBag.head = infovalue;   // 결과 카운트 
                        ViewBag.search = form.search;
                        return View(lstResult);
                    }

                    

                    // view 페이지에서 @item.각API스트링Key 으로 뽑아서 사용함
                    // ex) @item.idx

                    // 상위개체
                    // jObject["errorCode"], 
                    // jObject["totalCount"], 
                    // jObject["count"], 
                    // jObject["message"], 
                    // jObject["data"]

                    // 최하위 개체 접근  API 마다 틀림
                    // jObject["data"][0]["idx"],
                    // jObject["data"][0]["name"], 
                    // jObject["data"][0]["fileName"], 
                    // jObject["data"][0]["jpgFile"], 
                    // jObject["data"][0]["pdfFile"], 
                    // jObject["data"][0]["viewOrderby"]
                }
                else //web api sent error response 
                {

                    ModelState.AddModelError(string.Empty, "서버에러. 관리자에게 문의하세요.");

                    return View();
                }
            }

        }

        // PDF 미리보기 
        public ActionResult Preview(string idx)
        {

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);
                var visit = new requestModel();
                var responseTask = client.GetAsync("RequestFile?pageNo="+ idx + "&pageSize=1&includeFile=true"); // 각 API 종류에 맞게 수정
                    responseTask.Wait();
                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();
                    JObject jObject = JObject.Parse(readTask.Result);

                    visit.PDF_idx = jObject["data"][0]["idx"].ToString();
                    visit.PDF_name = jObject["data"][0]["name"].ToString();
                    visit.PDF_fileName = jObject["data"][0]["fileName"].ToString();
                    visit.PDF_jpgFile = jObject["data"][0]["jpgFile"].ToString();
                    visit.PDF_pdfFile = jObject["data"][0]["pdfFile"].ToString();
                    visit.PDF_viewOrderby = jObject["data"][0]["viewOrderby"].ToString();

                    var responseTask2 = client.GetAsync("requestfile/" + visit.PDF_idx + "?type=preview"); // 각 API 종류에 맞게 수정
                    responseTask2.Wait();
                    var result2 = responseTask2.Result;
                    var readTask2 = result2.Content.ReadAsStringAsync();
                    visit.PDF_pdfFileLink = readTask2.Result.ToString().Replace("\"", "");
                }

                ViewBag.visit = visit;

            }
                return View();
        }

        // PDF DOWN LOAD
        public ActionResult PdfDownload(string idx)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Properties.Settings.Default.CallApiAdress);
                var visit = new requestModel();
                var responseTask = client.GetAsync("RequestFile?pageNo=" + idx + "&pageSize=1&includeFile=true"); // 각 API 종류에 맞게 수정
                responseTask.Wait();
                var result = responseTask.Result;

                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsStringAsync();
                    JObject jObject = JObject.Parse(readTask.Result);

                    visit.PDF_idx = jObject["data"][0]["idx"].ToString();
                    visit.PDF_name = jObject["data"][0]["name"].ToString();
                    visit.PDF_fileName = jObject["data"][0]["fileName"].ToString();
                    visit.PDF_jpgFile = jObject["data"][0]["jpgFile"].ToString();
                    visit.PDF_pdfFile = jObject["data"][0]["pdfFile"].ToString();
                    visit.PDF_viewOrderby = jObject["data"][0]["viewOrderby"].ToString();
                }

                ViewBag.visit = visit;

            }

            return View();

        }
    }
}