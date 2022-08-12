using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Net.Http;


using System.Globalization;

using GCMaster.Modules;
using System.Web.Routing;
using Dapper;
using System.Data;

namespace GCMaster.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {
        protected AdminProfile AdminProfile { get; private set; }

        protected override void Initialize(RequestContext requestContext)
        {
            this.AdminProfile = AuthManager.GetAuthData(requestContext.HttpContext.User.Identity.Name);

            ViewBag.AdminProfile = AdminProfile;

            base.Initialize(requestContext);
        }

        /// <summary>
        /// 게시물 등록 결과 메세지
        /// </summary>
        /// <param name="result"></param>
        protected void SetViewMessageBoardCreate(bool result)
        {

            if (result)
                SetViewMessage("게시물이 등록되었습니다.");
            else
                SetViewMessage("게시물 등록에 실패하였습니다.");
        }

        /// <summary>
        /// 게시물 수정 결과 메세지
        /// </summary>
        /// <param name="result"></param>
        protected void SetViewMessageBoardEdit(bool result)
        {

            if (result)
                SetViewMessage("게시물이 수정되었습니다.");
            else
                SetViewMessage("게시물 수정에 실패하였습니다.");
        }

        /// <summary>
        /// 게시물 삭제 결과 메제시
        /// </summary>
        /// <param name="result"></param>
        protected void SetViewMessageBoardDelete(bool result)
        {

            if (result)
                SetViewMessage("게시물이 삭제되었습니다.");
            else
                SetViewMessage("게시물 삭제에 실패하였습니다.");
        }

        /// <summary>
        /// 이미지 삭제 결과 메세지
        /// </summary>
        /// <param name="result"></param>
        protected void SetViewMessageBoardDeleteImage(bool result)
        {

            if (result)
                SetViewMessage("이미지가 삭제되었습니다.");
            else
                SetViewMessage("이미지 삭제에 실패하였습니다.");
        }

        /// <summary>
        /// 첨부파일 삭제 결과 메세지
        /// </summary>
        /// <param name="result"></param>
        protected void SetViewMessageBoardDeleteFile(bool result)
        {

            if (result)
                SetViewMessage("첨부파일이 삭제되었습니다.");
            else
                SetViewMessage("첨부파일 삭제에 실패하였습니다.");
        }

        /// <summary>
        /// 예외 발생 메세지
        /// </summary>
        /// <param name="exceptionMessage"></param>
        protected void SetViewMessageException(string exceptionMessage)
        {

            SetViewMessage($"서버에러, 관리자에 문의 (에러내용 : {exceptionMessage.Replace("'", "`")})");
        }

        protected void SetViewMessage(string message)
        {
            TempData["viewMessage"] = message;
        }
    }
}