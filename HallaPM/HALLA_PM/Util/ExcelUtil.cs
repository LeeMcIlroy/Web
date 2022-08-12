using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using ClosedXML.Excel;
using System.ComponentModel;
using System.IO;

namespace HALLA_PM.Util
{
    public class ExcelUtil
    {
        /// <summary>
        /// 랜덤파일명 사용 함수
        /// </summary>
        int seq = 0;
        DataTable dt = new DataTable();
        
        private string getRandomString()
        {
            string name = DateTime.Now.ToString("yyyyMMdd_HHmmss_fff");
            return name + string.Format("{0:000", ++seq % 1000);
        }

        public void SetDataTable<T>(List<T> data)
        {
            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            foreach (PropertyDescriptor prop in properties)
                this.dt.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = this.dt.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                dt.Rows.Add(row);
            }
        }

        public void SetDataTable<T>(List<T> data, Dictionary<string, string> columnDic)
        {
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(typeof(T));
            foreach (PropertyDescriptor prop in properties)
            {
                if (columnDic.ContainsKey(prop.Name))
                {
                    dt.Columns.Add(columnDic[prop.Name], Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
                }
            }
            foreach (T item in data)
            {
                DataRow row = dt.NewRow();
                foreach (PropertyDescriptor prop in properties)
                {
                    if (columnDic.ContainsKey(prop.Name))
                    {
                        row[columnDic[prop.Name]] = prop.GetValue(item) ?? DBNull.Value;
                    }
                }
                dt.Rows.Add(row);
            }
        }

        public void ExportExcel()
        {
            HttpResponse response = HttpContext.Current.Response;
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(this.dt, "sheet1");

                response.Clear();
                response.Buffer = true;
                response.Charset = "";
                response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                response.AddHeader("content-disposition", "attachment;filename=" + getRandomString() + ".xlsx");
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    memoryStream.WriteTo(response.OutputStream);
                    response.Flush();
                    response.End();
                }
            }
        }

        public void SaveFileToExcel(string filePath)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(this.dt, "sheet1");
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    FileStream fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write);
                    memoryStream.WriteTo(fileStream);

                    fileStream.Dispose();
                    fileStream.Close();
                }
            }
        }

        public DataTable ImportExcel(string filePath)
        {
            DataTable dt = new DataTable();

            using (XLWorkbook wb = new XLWorkbook(filePath))
            {
                IXLWorksheet wSheet = wb.Worksheet(1);

                bool firstRow = true;
                int rowCount = 0;
                foreach (IXLRow row in wSheet.Rows())
                {
                    if(firstRow)
                    {
                        foreach (IXLCell cell in row.Cells())
                        {
                            dt.Columns.Add(cell.Value.ToString());
                            rowCount++;
                        }
                        firstRow = false;
                    }
                    else
                    {
                        dt.Rows.Add();
                        for (int i = 0; i < rowCount; i++)
                        {
                            dt.Rows[dt.Rows.Count - 1][i] = row.Cell(i + 1).Value.ToString();
                        }
                    }
                }
            }

            foreach (DataRow item in dt.Rows)
            {
                item.ToString();
            }
            return dt;
        }

        public DataSet ImportExcelDs(string filePath)
        {
            DataSet ds = new DataSet();

            using (XLWorkbook wb = new XLWorkbook(filePath))
            {
                foreach (var item in wb.Worksheets)
                {
                    IXLWorksheet wSheet = item;
                    ds.Tables.Add(wSheet.Name);

                    bool firstRow = true;
                    int rowCount = 0;

                    foreach (IXLRow row in wSheet.Rows())
                    {
                        if(firstRow)
                        {
                            foreach (IXLCell cell in row.Cells())
                            {
                                ds.Tables[wSheet.Name].Columns.Add(cell.Value.ToString());
                                rowCount++;
                            }
                            firstRow = false;
                            
                        }
                        else
                        {
                            ds.Tables[wSheet.Name].Rows.Add();
                            for (int i = 0; i < rowCount; i++)
                            {
                                ds.Tables[wSheet.Name].Rows[ds.Tables[wSheet.Name].Rows.Count - 1][i] = row.Cell(i + 1).Value.ToString();
                            }
                        }
                    }
                }
            }
            return ds;
        }
    }
}