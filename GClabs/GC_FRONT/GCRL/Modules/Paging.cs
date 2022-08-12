using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;

namespace GCRL.Modules
{
    public static class HtmlHelper
    {
        private static TagBuilder First(IPagedList list, Func<int, string> generatePageUrl)
        {
            const int targetPageNumber = 1;
            var first = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            first.AddCssClass("first");
            //first.AddCssClass("pg1");

            if (list.IsFirstPage)
                first.AddCssClass("disabled");
            else
            {
                first.Attributes["href"] = generatePageUrl(targetPageNumber);
            }

            //first.Attributes["style"] = "vertical-align:middle;";

            return first;
        }

        private static TagBuilder Previous(IPagedList list, Func<int, string> generatePageUrl)
        {
            var targetPageNumber = list.PageNumber - 1;
            var previous = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            previous.AddCssClass("pre");
            //previous.AddCssClass("none");
            //previous.AddCssClass("pg2");

            if (!list.HasPreviousPage)
                previous.AddCssClass("disabled");
            else
                previous.Attributes["href"] = generatePageUrl(targetPageNumber);

            //previous.Attributes["style"] = "vertical-align:middle;";

            return previous;
        }

        private static TagBuilder Page(int i, IPagedList list, Func<int, string> generatePageUrl)
        {
            var targetPageNumber = i;
            var page = new TagBuilder("a")
            {
                InnerHtml = targetPageNumber.ToString()
            };

            if (i != list.PageNumber)
            {
                //page.AddCssClass("off");
                page.Attributes["href"] = generatePageUrl(targetPageNumber);
            }

            //page.Attributes["style"] = "vertical-align:middle;";

            var li = new TagBuilder("li")
            {
                InnerHtml = page.ToString()
            };

            if (i == list.PageNumber)
                li.AddCssClass("on");

            return li;
        }

        private static TagBuilder Next(IPagedList list, Func<int, string> generatePageUrl)
        {
            var targetPageNumber = list.PageNumber + 1;
            var next = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            next.AddCssClass("next");
            //next.AddCssClass("none");
            //next.AddCssClass("pg3");

            if (!list.HasNextPage)
                next.AddCssClass("disabled");
            else
                next.Attributes["href"] = generatePageUrl(targetPageNumber);

            //next.Attributes["style"] = "vertical-align:middle;";

            return next;
        }

        private static TagBuilder Last(IPagedList list, Func<int, string> generatePageUrl)
        {
            var targetPageNumber = list.PageCount;
            var last = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            last.AddCssClass("last");
            //last.AddCssClass("pg4");

            if (list.IsLastPage)
                last.AddCssClass("disabled");
            else
            {
                last.Attributes["href"] = generatePageUrl(targetPageNumber);
            }

            //last.Attributes["style"] = "vertical-align:middle;";

            return last;
        }

        private static TagBuilder pagingUl(List<TagBuilder> lis)
        {
            var liString = lis.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            var ul = new TagBuilder("ul")
            {
                InnerHtml = liString
            };

            ul.AddCssClass("paging");

            return ul;
        }

        public static MvcHtmlString PagingBoardPager(this System.Web.Mvc.HtmlHelper html, IPagedList list, Func<int, string> generatePageUrl)
        {
            if (list.PageCount <= 1)
                return null;

            var listItemLinks = new List<TagBuilder>();

            //calculate start and end of range of page numbers
            var firstPageToDisplay = 1;
            var lastPageToDisplay = list.PageCount;
            var pageNumbersToDisplay = lastPageToDisplay;

            //if (options.MaximumPageNumbersToDisplay.HasValue && list.PageCount > options.MaximumPageNumbersToDisplay)
            //{
            //    // cannot fit all pages into pager
            //    var maxPageNumbersToDisplay = options.MaximumPageNumbersToDisplay.Value;
            //    firstPageToDisplay = list.PageNumber - maxPageNumbersToDisplay / 2;
            //    if (firstPageToDisplay < 1)
            //        firstPageToDisplay = 1;
            //    pageNumbersToDisplay = maxPageNumbersToDisplay;
            //    lastPageToDisplay = firstPageToDisplay + pageNumbersToDisplay - 1;
            //    if (lastPageToDisplay > list.PageCount)
            //        firstPageToDisplay = list.PageCount - maxPageNumbersToDisplay + 1;
            //}

            //first
            listItemLinks.Add(First(list, generatePageUrl));

            //previous
            listItemLinks.Add(Previous(list, generatePageUrl));


            //page
            {
                var listItemlis = new List<TagBuilder>();

                foreach (var i in Enumerable.Range(firstPageToDisplay, pageNumbersToDisplay))
                {
                    //show page number link
                    listItemlis.Add(Page(i, list, generatePageUrl));
                }

                listItemLinks.Add(pagingUl(listItemlis));

            }

            //next
            listItemLinks.Add(Next(list, generatePageUrl));

            //last
            listItemLinks.Add(Last(list, generatePageUrl));

            //collapse all of the list items into one big string
            var listItemLinksString = listItemLinks.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            return new MvcHtmlString(listItemLinksString);
        }

        public static MvcHtmlString PagingBoardPager(this System.Web.Mvc.HtmlHelper html, IPagedList list, Func<int, string> generatePageUrl, PagedListRenderOptions options)
        {
            if (list.PageCount <= 1)
                return null;

            var listItemLinks = new List<TagBuilder>();

            //calculate start and end of range of page numbers
            var firstPageToDisplay = 1;
            var lastPageToDisplay = list.PageCount;
            var pageNumbersToDisplay = lastPageToDisplay;

            if (options.MaximumPageNumbersToDisplay.HasValue && list.PageCount > options.MaximumPageNumbersToDisplay)
            {
                // cannot fit all pages into pager
                var maxPageNumbersToDisplay = options.MaximumPageNumbersToDisplay.Value;

                if (list.PageNumber > 10 && (list.PageNumber) % 10 == 1)
                {
                    firstPageToDisplay = list.PageNumber;
                }
                else
                {
                    int ipage = Convert.ToInt32(Math.Truncate(Convert.ToDouble(list.PageNumber / 10))) * 10;
                    firstPageToDisplay = list.PageNumber % 10 == 0 ? ipage - 9 : ipage + 1;
                }                                  

                if (firstPageToDisplay < 1)
                    firstPageToDisplay = 1;
                
                pageNumbersToDisplay = maxPageNumbersToDisplay;
                lastPageToDisplay = firstPageToDisplay + pageNumbersToDisplay - 1;
                
                if (lastPageToDisplay > list.PageCount)
                    firstPageToDisplay = list.PageCount - maxPageNumbersToDisplay + 1;
            }

            //first
            listItemLinks.Add(First(list, generatePageUrl));

            //previous
            listItemLinks.Add(Previous(list, generatePageUrl));


            //page
            {
                var listItemlis = new List<TagBuilder>();

                foreach (var i in Enumerable.Range(firstPageToDisplay, pageNumbersToDisplay))
                {
                    //show page number link
                    listItemlis.Add(Page(i, list, generatePageUrl));
                }

                listItemLinks.Add(pagingUl(listItemlis));
            }

            //next
            listItemLinks.Add(Next(list, generatePageUrl));

            //last
            listItemLinks.Add(Last(list, generatePageUrl));

            //collapse all of the list items into one big string
            var listItemLinksString = listItemLinks.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            return new MvcHtmlString(listItemLinksString);
        }

        public static MvcHtmlString PagingBoardPager_M(this System.Web.Mvc.HtmlHelper html, IPagedList list, Func<int, string> generatePageUrl)
        {
            if (list.PageCount <= 1)
                return null;

            var listItemLinks = new List<TagBuilder>();

            //calculate start and end of range of page numbers
            var firstPageToDisplay = 1;
            var lastPageToDisplay = list.PageCount;
            var pageNumbersToDisplay = lastPageToDisplay;

            //if (options.MaximumPageNumbersToDisplay.HasValue && list.PageCount > options.MaximumPageNumbersToDisplay)
            //{
                // cannot fit all pages into pager
                var maxPageNumbersToDisplay = 3;

                if (list.PageNumber > 3 && (list.PageNumber) % 3 == 1)
                {
                    firstPageToDisplay = list.PageNumber;
                }
                else
                {
                    int ipage = Convert.ToInt32(Math.Truncate(Convert.ToDouble(list.PageNumber / 3))) * 3;
                    firstPageToDisplay = list.PageNumber % 3 == 0 ? ipage - 2 : ipage + 1;
                }

                //if (firstPageToDisplay < 1)
                //    firstPageToDisplay = 1;

                pageNumbersToDisplay = lastPageToDisplay < 3 ? lastPageToDisplay : maxPageNumbersToDisplay;
                lastPageToDisplay = firstPageToDisplay + pageNumbersToDisplay - 1;

                if (lastPageToDisplay > list.PageCount)
                    firstPageToDisplay = list.PageCount - maxPageNumbersToDisplay + 1;

                if (firstPageToDisplay < 1)
                    firstPageToDisplay = 1;
            //}

            //first
            listItemLinks.Add(First(list, generatePageUrl));

            //previous
            listItemLinks.Add(Previous(list, generatePageUrl));


            //page
            {
                var listItemlis = new List<TagBuilder>();

                foreach (var i in Enumerable.Range(firstPageToDisplay, pageNumbersToDisplay))
                {
                    //show page number link
                    listItemlis.Add(Page(i, list, generatePageUrl));
                }

                listItemLinks.Add(pagingUl(listItemlis));
            }

            //next
            listItemLinks.Add(Next(list, generatePageUrl));

            //last
            listItemLinks.Add(Last(list, generatePageUrl));

            //collapse all of the list items into one big string
            var listItemLinksString = listItemLinks.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            return new MvcHtmlString(listItemLinksString);
        }

        #region 페이징 ver2
        public static MvcHtmlString PagingBoardPager2(this System.Web.Mvc.HtmlHelper html, IPagedList list, Func<int, string> generatePageUrl, PagedListRenderOptions options)
        {
            var totalCount = html.ViewBag.head;    //검사항목 API - totalCount
            var nowPageNo = html.ViewBag.pageNo;   //검사항목 API - pageNo

            if (totalCount <= 1)
                return null;

            var listItemLinks = new List<TagBuilder>();

            //calculate start and end of range of page numbers
            var firstPageToDisplay = 1;
            //var lastPageToDisplay = Math.Ceiling(Convert.ToDouble(totalCount / 10));
            var lastPageToDisplay = totalCount;
            var pageNumbersToDisplay = lastPageToDisplay;
            var totalPage = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(lastPageToDisplay / 10.0)));

            if (options.MaximumPageNumbersToDisplay.HasValue && totalCount > options.MaximumPageNumbersToDisplay)
            {
                // cannot fit all pages into pager
                var maxPageNumbersToDisplay = options.MaximumPageNumbersToDisplay.Value;

                if (nowPageNo > 10 && (nowPageNo % 10) == 1)
                {
                    firstPageToDisplay = nowPageNo;
                }
                else
                {
                    int ipage = Convert.ToInt32(Math.Truncate(Convert.ToDouble(nowPageNo / 10))) * 10;
                    firstPageToDisplay = nowPageNo % 10 == 0 ? ipage - 9 : ipage + 1;
                }

                if (firstPageToDisplay < 1)
                    firstPageToDisplay = 1;

                pageNumbersToDisplay = maxPageNumbersToDisplay;
                lastPageToDisplay = firstPageToDisplay + pageNumbersToDisplay - 1;

                if (lastPageToDisplay > totalPage)
                {
                    lastPageToDisplay = totalPage;
                    pageNumbersToDisplay = (lastPageToDisplay - firstPageToDisplay) + 1;
                }

                if (lastPageToDisplay > totalCount)
                    firstPageToDisplay = totalCount - maxPageNumbersToDisplay + 1;
            }
            else
            {
                pageNumbersToDisplay = 1;
            }

            //first
            listItemLinks.Add(First(list, generatePageUrl, nowPageNo, totalCount));

            //previous
            listItemLinks.Add(Previous(list, generatePageUrl, nowPageNo));


            //page
            var listItemlis = new List<TagBuilder>();
            foreach (var i in Enumerable.Range(firstPageToDisplay, pageNumbersToDisplay))
            {
                //show page number link
                listItemlis.Add(Page(i, list, generatePageUrl, nowPageNo));
            }
            listItemLinks.Add(pagingUl(listItemlis));

            //next
            listItemLinks.Add(Next(list, generatePageUrl, nowPageNo, totalCount));

            //last
            listItemLinks.Add(Last(list, generatePageUrl, nowPageNo, totalCount));

            //collapse all of the list items into one big string
            var listItemLinksString = listItemLinks.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            return new MvcHtmlString(listItemLinksString);
        }

        public static MvcHtmlString PagingBoardPager2_M(this System.Web.Mvc.HtmlHelper html, IPagedList list, Func<int, string> generatePageUrl)
        {
            var totalCount = html.ViewBag.head;    //검사항목 API - totalCount
            var nowPageNo = html.ViewBag.pageNo;   //검사항목 API - pageNo

            if (totalCount <= 1)
                return null;

            var listItemLinks = new List<TagBuilder>();

            //calculate start and end of range of page numbers
            var firstPageToDisplay = 1;
            var lastPageToDisplay = totalCount;
            var pageNumbersToDisplay = lastPageToDisplay;
            var totalPage = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(lastPageToDisplay / 3.0)));

            //if (options.MaximumPageNumbersToDisplay.HasValue && totalCount > options.MaximumPageNumbersToDisplay)
            //{
                // cannot fit all pages into pager
                var maxPageNumbersToDisplay = 3;

                if (nowPageNo > 3 && (nowPageNo % 3) == 1)
                {
                    firstPageToDisplay = nowPageNo;
                }
                else
                {
                    int ipage = Convert.ToInt32(Math.Truncate(Convert.ToDouble(nowPageNo / 3))) * 3;
                    firstPageToDisplay = nowPageNo % 3 == 0 ? ipage - 2 : ipage + 1;
                }

                if (firstPageToDisplay < 1)
                    firstPageToDisplay = 1;

                pageNumbersToDisplay = maxPageNumbersToDisplay;
                lastPageToDisplay = firstPageToDisplay + pageNumbersToDisplay - 1;

                if (lastPageToDisplay > totalPage)
                {
                    lastPageToDisplay = totalPage;
                    pageNumbersToDisplay = (lastPageToDisplay - firstPageToDisplay) + 1;
                }

                if (lastPageToDisplay > totalCount)
                    firstPageToDisplay = totalCount - maxPageNumbersToDisplay + 1;
            //}
            //else
            //{
                //pageNumbersToDisplay = 1;
            //}

            //first
            listItemLinks.Add(First(list, generatePageUrl, nowPageNo, totalCount));

            //previous
            listItemLinks.Add(Previous(list, generatePageUrl, nowPageNo));


            //page
            var listItemlis = new List<TagBuilder>();
            foreach (var i in Enumerable.Range(firstPageToDisplay, pageNumbersToDisplay))
            {
                //show page number link
                listItemlis.Add(Page(i, list, generatePageUrl, nowPageNo));
            }
            listItemLinks.Add(pagingUl(listItemlis));

            //next
            listItemLinks.Add(Next(list, generatePageUrl, nowPageNo, totalCount));

            //last
            listItemLinks.Add(Last(list, generatePageUrl, nowPageNo, totalCount));

            //collapse all of the list items into one big string
            var listItemLinksString = listItemLinks.Aggregate(
                new StringBuilder(),
                (sb, listItem) => sb.Append(listItem.ToString()).AppendLine(),
                sb => sb.ToString()
                );

            return new MvcHtmlString(listItemLinksString);
        }

        private static TagBuilder First(IPagedList list, Func<int, string> generatePageUrl, int nowPageNo, int totalCount)
        {
            //var totalPage = Math.Ceiling(totalCount / 10.0);
            const int targetPageNumber = 1;
            var first = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            first.AddCssClass("first");

            if (nowPageNo == 1)
                first.AddCssClass("disabled");
            else
                first.Attributes["href"] = generatePageUrl(targetPageNumber);

            //first.Attributes["style"] = "vertical-align:middle;";

            return first;
        }

        private static TagBuilder Previous(IPagedList list, Func<int, string> generatePageUrl, int nowPageNo)
        {
            var targetPageNumber = nowPageNo - 1;
            var previous = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            previous.AddCssClass("pre");

            //if (!list.HasPreviousPage)
            if (nowPageNo == 1)
                previous.AddCssClass("disabled");
            else
                previous.Attributes["href"] = generatePageUrl(targetPageNumber);

            //previous.Attributes["style"] = "vertical-align:middle;";

            return previous;
        }

        private static TagBuilder Page(int i, IPagedList list, Func<int, string> generatePageUrl, int nowPageNo)
        {
            var targetPageNumber = i;
            var page = new TagBuilder("a")
            {
                InnerHtml = targetPageNumber.ToString()
            };

            //if (nowPageNo == i)
            //{
            //    page.AddCssClass("on");
            //}
            //else
            //{
            //    page.AddCssClass("off");
            //}

            if (nowPageNo != i)
                page.Attributes["href"] = generatePageUrl(targetPageNumber);
            //page.Attributes["style"] = "vertical-align:middle;";

            var li = new TagBuilder("li")
            {
                InnerHtml = page.ToString()
            };

            if (nowPageNo == i)
            {
                li.AddCssClass("on");
            }

            return li;
        }

        private static TagBuilder Next(IPagedList list, Func<int, string> generatePageUrl, int nowPageNo, int totalCount)
        {
            var targetPageNumber = nowPageNo + 1;
            var next = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            next.AddCssClass("next");

            //if (!list.HasNextPage)
            if (targetPageNumber <= (totalCount % 10))
                next.AddCssClass("disabled");
            else
                next.Attributes["href"] = generatePageUrl(targetPageNumber);

            //next.Attributes["style"] = "vertical-align:middle;";

            return next;
        }

        private static TagBuilder Last(IPagedList list, Func<int, string> generatePageUrl, int nowPageNo, int totalCount)
        {
            var totalPage = Math.Ceiling(totalCount / 10.0);
            var targetPageNumber = Convert.ToInt32(totalPage);
            var last = new TagBuilder("a")
            {
                InnerHtml = ""
            };

            last.AddCssClass("last");

            //if (list.IsLastPage)
            if (targetPageNumber == nowPageNo)
                last.AddCssClass("disabled");
            else
                last.Attributes["href"] = generatePageUrl(targetPageNumber);

            //last.Attributes["style"] = "vertical-align:middle;";

            return last;
        }
        #endregion
    }



    //   public static class PagingExtention
    //   {
    //	/// <summary>
    //	/// Creates a subset of this collection of objects that can be individually accessed by index and containing metadata about the collection of objects the subset was created from.
    //	/// </summary>
    //	/// <typeparam name="T">The type of object the collection should contain.</typeparam>
    //	/// <param name="superset">The collection of objects to be divided into subsets. If the collection implements <see cref="IQueryable{T}"/>, it will be treated as such.</param>
    //	/// <param name="pageNumber">The one-based index of the subset of objects to be contained by this instance.</param>
    //	/// <param name="pageSize">The maximum size of any individual subset.</param>
    //	/// <returns>A subset of this collection of objects that can be individually accessed by index and containing metadata about the collection of objects the subset was created from.</returns>
    //	/// <seealso cref="Paging{T}"/>
    //	public static IPaging<T> ToPagedList<T>(this IEnumerable<T> superset, int pageNumber, int pageSize)
    //	{
    //		return new Paging<T>(superset, pageNumber, pageSize);
    //	}

    //	/// <summary>
    //	/// Creates a subset of this collection of objects that can be individually accessed by index and containing metadata about the collection of objects the subset was created from.
    //	/// </summary>
    //	/// <typeparam name="T">The type of object the collection should contain.</typeparam>
    //	/// <param name="superset">The collection of objects to be divided into subsets. If the collection implements <see cref="IQueryable{T}"/>, it will be treated as such.</param>
    //	/// <param name="pageNumber">The one-based index of the subset of objects to be contained by this instance.</param>
    //	/// <param name="pageSize">The maximum size of any individual subset.</param>
    //	/// <returns>A subset of this collection of objects that can be individually accessed by index and containing metadata about the collection of objects the subset was created from.</returns>
    //	/// <seealso cref="Paging{T}"/>
    //	public static IPaging<T> ToPagedList<T>(this IQueryable<T> superset, int pageNumber, int pageSize)
    //	{
    //		return new Paging<T>(superset, pageNumber, pageSize);
    //	}
    //}

    //   public interface IPaging<out T> : IPaging
    //   {
    //       ///<summary>
    //       /// Gets the element at the specified index.
    //       ///</summary>
    //       ///<param name="index">The zero-based index of the element to get.</param>
    //       T this[int index] { get; }

    //       ///<summary>
    //       /// Gets the number of elements contained on this page.
    //       ///</summary>
    //       int Count { get; }

    //       ///<summary>
    //       /// Gets a non-enumerable copy of this paged list.
    //       ///</summary>
    //       ///<returns>A non-enumerable copy of this paged list.</returns>
    //       IPaging GetMetaData();
    //   }

    //public interface IPaging
    //{
    //	/// <summary>
    //	/// Total number of subsets within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Total number of subsets within the superset.
    //	/// </value>
    //	int PageCount { get; }

    //	/// <summary>
    //	/// Total number of objects contained within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Total number of objects contained within the superset.
    //	/// </value>
    //	int TotalItemCount { get; }

    //	/// <summary>
    //	/// One-based index of this subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// One-based index of this subset within the superset.
    //	/// </value>
    //	int PageNumber { get; }

    //	/// <summary>
    //	/// Maximum size any individual subset.
    //	/// </summary>
    //	/// <value>
    //	/// Maximum size any individual subset.
    //	/// </value>
    //	int PageSize { get; }

    //	/// <summary>
    //	/// Returns true if this is NOT the first subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Returns true if this is NOT the first subset within the superset.
    //	/// </value>
    //	bool HasPreviousPage { get; }

    //	/// <summary>
    //	/// Returns true if this is NOT the last subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Returns true if this is NOT the last subset within the superset.
    //	/// </value>
    //	bool HasNextPage { get; }

    //	/// <summary>
    //	/// Returns true if this is the first subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Returns true if this is the first subset within the superset.
    //	/// </value>
    //	bool IsFirstPage { get; }

    //	/// <summary>
    //	/// Returns true if this is the last subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// Returns true if this is the last subset within the superset.
    //	/// </value>
    //	bool IsLastPage { get; }

    //	/// <summary>
    //	/// One-based index of the first item in the paged subset.
    //	/// </summary>
    //	/// <value>
    //	/// One-based index of the first item in the paged subset.
    //	/// </value>
    //	int FirstItemOnPage { get; }

    //	/// <summary>
    //	/// One-based index of the last item in the paged subset.
    //	/// </summary>
    //	/// <value>
    //	/// One-based index of the last item in the paged subset.
    //	/// </value>
    //	int LastItemOnPage { get; }
    //}

    //[Serializable]
    //public class PagingMetaData : IPaging
    //{
    //	/// <summary>
    //	/// Protected constructor that allows for instantiation without passing in a separate list.
    //	/// </summary>
    //	protected PagingMetaData()
    //	{
    //	}

    //	///<summary>
    //	/// Non-enumerable version of the PagedList class.
    //	///</summary>
    //	///<param name="paging">A PagedList (likely enumerable) to copy metadata from.</param>
    //	public PagingMetaData(IPaging paging)
    //	{
    //		PageCount = paging.PageCount;
    //		TotalItemCount = paging.TotalItemCount;
    //		PageNumber = paging.PageNumber;
    //		PageSize = paging.PageSize;
    //		HasPreviousPage = paging.HasPreviousPage;
    //		HasNextPage = paging.HasNextPage;
    //		IsFirstPage = paging.IsFirstPage;
    //		IsLastPage = paging.IsLastPage;
    //		FirstItemOnPage = paging.FirstItemOnPage;
    //		LastItemOnPage = paging.LastItemOnPage;
    //	}

    //	#region IPagedList Members

    //	/// <summary>
    //	/// 	Total number of subsets within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Total number of subsets within the superset.
    //	/// </value>
    //	public int PageCount { get; protected set; }

    //	/// <summary>
    //	/// 	Total number of objects contained within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Total number of objects contained within the superset.
    //	/// </value>
    //	public int TotalItemCount { get; protected set; }

    //	/// <summary>
    //	/// 	One-based index of this subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	One-based index of this subset within the superset.
    //	/// </value>
    //	public int PageNumber { get; protected set; }

    //	/// <summary>
    //	/// 	Maximum size any individual subset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Maximum size any individual subset.
    //	/// </value>
    //	public int PageSize { get; protected set; }

    //	/// <summary>
    //	/// 	Returns true if this is NOT the first subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Returns true if this is NOT the first subset within the superset.
    //	/// </value>
    //	public bool HasPreviousPage { get; protected set; }

    //	/// <summary>
    //	/// 	Returns true if this is NOT the last subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Returns true if this is NOT the last subset within the superset.
    //	/// </value>
    //	public bool HasNextPage { get; protected set; }

    //	/// <summary>
    //	/// 	Returns true if this is the first subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Returns true if this is the first subset within the superset.
    //	/// </value>
    //	public bool IsFirstPage { get; protected set; }

    //	/// <summary>
    //	/// 	Returns true if this is the last subset within the superset.
    //	/// </summary>
    //	/// <value>
    //	/// 	Returns true if this is the last subset within the superset.
    //	/// </value>
    //	public bool IsLastPage { get; protected set; }

    //	/// <summary>
    //	/// 	One-based index of the first item in the paged subset.
    //	/// </summary>
    //	/// <value>
    //	/// 	One-based index of the first item in the paged subset.
    //	/// </value>
    //	public int FirstItemOnPage { get; protected set; }

    //	/// <summary>
    //	/// 	One-based index of the last item in the paged subset.
    //	/// </summary>
    //	/// <value>
    //	/// 	One-based index of the last item in the paged subset.
    //	/// </value>
    //	public int LastItemOnPage { get; protected set; }

    //	#endregion
    //}


    //[Serializable]
    //public abstract class BasePaging<T> : PagingMetaData, IPaging<T>
    //{
    //       protected readonly List<T> ResultSet = new List<T>();

    //       protected internal BasePaging()
    //       {

    //       }

    //       protected internal BasePaging(int pageNumber, int rowCount, int totalRowCount)
    //       {
    //		if (pageNumber < 1)
    //			throw new ArgumentOutOfRangeException("pageNumber", pageNumber, "PageNumber cannot be below 1.");
    //		if (rowCount < 1)
    //			throw new ArgumentOutOfRangeException("pageSize", rowCount, "PageSize cannot be less than 1.");

    //		// set source to blank list if superset is null to prevent exceptions
    //		TotalItemCount = totalRowCount;
    //		PageSize = rowCount;
    //		PageNumber = pageNumber;
    //		PageCount = TotalItemCount > 0
    //						? (int)Math.Ceiling(TotalItemCount / (double)PageSize)
    //						: 0;
    //		HasPreviousPage = PageNumber > 1;
    //		HasNextPage = PageNumber < PageCount;
    //		IsFirstPage = PageNumber == 1;
    //		IsLastPage = PageNumber >= PageCount;
    //		FirstItemOnPage = (PageNumber - 1) * PageSize + 1;
    //		var numberOfLastItemOnPage = FirstItemOnPage + PageSize - 1;
    //		LastItemOnPage = numberOfLastItemOnPage > TotalItemCount
    //							 ? TotalItemCount
    //							 : numberOfLastItemOnPage;
    //	}

    //       public T this[int index]
    //       {
    //           get { return ResultSet[index]; }
    //       }

    //       public int Count
    //       {
    //           get { return ResultSet.Count; }
    //       }

    //       public IPaging GetMetaData()
    //       {
    //           return new PagingMetaData(this);
    //       }
    //   }

    //[Serializable]
    //public class Paging<T> : BasePaging<T>
    //{
    //	/// <summary>
    //	/// Initializes a new instance of the <see cref="Paging{T}"/> class that divides the supplied superset into subsets the size of the supplied pageSize. The instance then only containes the objects contained in the subset specified by index.
    //	/// </summary>
    //	/// <param name="superset">The collection of objects to be divided into subsets. If the collection implements <see cref="IQueryable{T}"/>, it will be treated as such.</param>
    //	/// <param name="pageNumber">The one-based index of the subset of objects to be contained by this instance.</param>
    //	/// <param name="pageSize">The maximum size of any individual subset.</param>
    //	/// <exception cref="ArgumentOutOfRangeException">The specified index cannot be less than zero.</exception>
    //	/// <exception cref="ArgumentOutOfRangeException">The specified page size cannot be less than one.</exception>
    //	public Paging(IQueryable<T> superset, int pageNumber, int pageSize)
    //	{
    //		if (pageNumber < 1)
    //			throw new ArgumentOutOfRangeException("pageNumber", pageNumber, "PageNumber cannot be below 1.");
    //		if (pageSize < 1)
    //			throw new ArgumentOutOfRangeException("pageSize", pageSize, "PageSize cannot be less than 1.");

    //		// set source to blank list if superset is null to prevent exceptions
    //		TotalItemCount = superset == null ? 0 : superset.Count();
    //		PageSize = pageSize;
    //		PageNumber = pageNumber;
    //		PageCount = TotalItemCount > 0
    //					? (int)Math.Ceiling(TotalItemCount / (double)PageSize)
    //					: 0;
    //		HasPreviousPage = PageNumber > 1;
    //		HasNextPage = PageNumber < PageCount;
    //		IsFirstPage = PageNumber == 1;
    //		IsLastPage = PageNumber >= PageCount;
    //		FirstItemOnPage = (PageNumber - 1) * PageSize + 1;
    //		var numberOfLastItemOnPage = FirstItemOnPage + PageSize - 1;
    //		LastItemOnPage = numberOfLastItemOnPage > TotalItemCount
    //						? TotalItemCount
    //						: numberOfLastItemOnPage;

    //		// add items to internal list
    //		if (superset != null && TotalItemCount > 0)
    //			ResultSet.AddRange(pageNumber == 1
    //				? superset.Skip(0).Take(pageSize).ToList()
    //				: superset.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList()
    //			);
    //	}

    //	/// <summary>
    //	/// Initializes a new instance of the <see cref="Paging{T}"/> class that divides the supplied superset into subsets the size of the supplied pageSize. The instance then only containes the objects contained in the subset specified by index.
    //	/// </summary>
    //	/// <param name="superset">The collection of objects to be divided into subsets. If the collection implements <see cref="IQueryable{T}"/>, it will be treated as such.</param>
    //	/// <param name="pageNumber">The one-based index of the subset of objects to be contained by this instance.</param>
    //	/// <param name="pageSize">The maximum size of any individual subset.</param>
    //	/// <exception cref="ArgumentOutOfRangeException">The specified index cannot be less than zero.</exception>
    //	/// <exception cref="ArgumentOutOfRangeException">The specified page size cannot be less than one.</exception>
    //	public Paging(IEnumerable<T> superset, int pageNumber, int pageSize)
    //		: this(superset.AsQueryable<T>(), pageNumber, pageSize)
    //	{
    //	}
    //}


}