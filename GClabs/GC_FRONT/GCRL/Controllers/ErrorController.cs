﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Controllers
{
    public class ErrorController : Controller
    {
        // GET: Error
        
        public ActionResult error()
        {
            
            Response.TrySkipIisCustomErrors = true;
            Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            return View();
        }

   
    }
}