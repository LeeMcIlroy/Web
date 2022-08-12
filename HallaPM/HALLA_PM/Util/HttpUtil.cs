using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using RestSharp;

namespace HALLA_PM.Util
{
    public class HttpUtil : RestSharp.RestClient
    {
        public RestRequest request;

        public HttpUtil(string url, string request, Method method)
        {
            this.BaseUrl = new Uri(url);
            this.request = new RestRequest(request, method);
            this.request.Timeout = 20 * 1000;
        }

        public List<T> Execute<T>()
        {
            return Execute<List<T>>(request).Data;
        }

        public override IRestResponse<T> Execute<T>(IRestRequest restRequest)
        {
            var response = base.Execute<T>(restRequest);
            TimeoutCheck(restRequest, response);
            return response;
        }

        private void TimeoutCheck(IRestRequest request, IRestResponse response)
        {
            if (response.StatusCode == 0)
            {
                throw new TimeoutException("HttpUtil request timed out");
            }
        }
    }
}