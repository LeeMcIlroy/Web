// Decompiled with JetBrains decompiler
// Type: Castle.Data.DataCommand
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using System.Text.RegularExpressions;

namespace Castle.Data
{
  public class DataCommand
  {
    protected DataAgent Agent;

    public static IQuery Query { set; get; }

    public DataCommand()
    {
      this.Parameter = new DataPack();
      this.UseSP = false;
    }

    public DataCommand(DataAgent agent, string rawText, bool useSP)
    {
      this.Agent = agent;
      this.RawText = rawText;
      this.Parameter = new DataPack();
      this.UseSP = useSP;
    }

    public string QueryID { set; get; }

    protected string RawText { set; get; }

    public string CommandText { set; get; }

    public DataPack Parameter { set; get; }

    public bool UseSP { set; get; }

    public static List<DataParamSource> GetParamSourceData(
      params object[] paramSource)
    {
      for (int index = 0; index < paramSource.Length; ++index)
      {
        if (paramSource[index] == null)
          paramSource[index] = (object) new{  };
      }
      List<DataParamSource> dataParamSourceList = new List<DataParamSource>(paramSource.Length);
      foreach (object obj in paramSource)
      {
        foreach (PropertyInfo property in obj.GetType().GetProperties())
        {
          DataParamSource dataParamSource = new DataParamSource();
          string empty = string.Empty;
          ColumnNameAttribute[] customAttributes1 = (ColumnNameAttribute[]) property.GetCustomAttributes(typeof (ColumnNameAttribute), false);
          if (customAttributes1.Length != 0)
            dataParamSource.ColumnName = customAttributes1[0].ColumnName;
          dataParamSource.Name = property.Name;
          dataParamSource.ValueProperty = property;
          dataParamSource.ValueSourceObject = obj;
          SQLDataType[] customAttributes2 = (SQLDataType[]) property.GetCustomAttributes(typeof (SQLDataType), false);
          if (customAttributes2.Length != 0)
            dataParamSource.Type = customAttributes2[0];
          dataParamSourceList.Add(dataParamSource);
        }
      }
      return dataParamSourceList;
    }

    public static DataCommand GetCommand(
      DataAgent agent,
      string qryid,
      params object[] paramSource)
    {
      for (int index = 0; index < paramSource.Length; ++index)
      {
        if (paramSource[index] == null)
          paramSource[index] = (object) new{  };
      }
      List<DataParamSource> paramSourceData = DataCommand.GetParamSourceData(paramSource);
      DataCommand matchCommand = DataCommand.Query.GetMatchCommand(agent, qryid, paramSourceData);
      foreach (KeyValuePair<string, DataParameter> keyValuePair in (Dictionary<string, DataParameter>) matchCommand.Parameter)
      {
        foreach (DataParamSource dataParamSource in paramSourceData)
        {
          if ((keyValuePair.Value.ParameterName.IsDataNameMatch(dataParamSource.Name) || keyValuePair.Value.ParameterName.IsDataNameMatch(dataParamSource.ColumnName)) && (dataParamSource.ValueSourceObject is DataEntity valueSourceObject && valueSourceObject.ValidState.ContainsKey(dataParamSource.Name)) && !valueSourceObject.ValidState[dataParamSource.Name])
            throw new ArgumentException("Not Valid", dataParamSource.Name);
        }
      }
      matchCommand.BuildCommand(paramSourceData);
      return matchCommand;
    }

    public void BuildCommand(List<DataParamSource> paramSource)
    {
      if (this.UseSP)
        this.BuildSPCommand(paramSource);
      else
        this.BuildTextCommand(paramSource);
    }

    protected void BuildTextCommand(List<DataParamSource> paramSource)
    {
      this.CommandText = this.RawText;
      foreach (Match match in this.Agent.ParameterRegex.Matches(this.RawText))
      {
        bool flag = match.Value[0] == 'N';
        string str = string.Empty;
        object initValue = (object) null;
        SQLDataType sqlDataType = (SQLDataType) null;
        foreach (DataParamSource dataParamSource in paramSource)
        {
          string src = match.Groups[2].Value;
          if (src.IsDataNameMatch(dataParamSource.Name) || src.IsDataNameMatch(dataParamSource.ColumnName))
          {
            str = src;
            initValue = !(dataParamSource.ValueProperty == (PropertyInfo) null) ? dataParamSource.ValueProperty.GetGetMethod().Invoke(dataParamSource.ValueSourceObject, (object[]) null) : dataParamSource.Value;
            sqlDataType = dataParamSource.Type;
            break;
          }
        }
        if (!string.IsNullOrEmpty(str) && !this.Parameter.ContainsKey(str))
        {
          DataParameter dataParameter = this.Parameter.Add(str, initValue);
          if (initValue != null)
            dataParameter.Type = initValue.GetType();
          if (sqlDataType == null)
          {
            this.Parameter[str].Value = initValue;
            if (flag)
              dataParameter.SqlType = new SqlDbType?(SqlDbType.NVarChar);
          }
          else
            dataParameter.SqlType = new SqlDbType?(sqlDataType.DataType);
        }
      }
      foreach (Match match in this.Agent.SubRegex.Matches(this.RawText))
      {
        if (match.Groups.Count >= 2)
        {
          string src = match.Groups[1].Value;
          bool flag = false;
          foreach (DataParamSource dataParamSource in paramSource)
          {
            if (src.IsDataNameMatch(dataParamSource.Name) || src.IsDataNameMatch(dataParamSource.ColumnName))
            {
              string newValue = !(dataParamSource.ValueProperty == (PropertyInfo) null) ? dataParamSource.ValueProperty.GetGetMethod().Invoke(dataParamSource.ValueSourceObject, (object[]) null).ToString() : dataParamSource.Value.ToString();
              this.CommandText = this.CommandText.Replace(match.Value, newValue);
              flag = true;
            }
          }
          if (!flag)
            this.CommandText = this.CommandText.Replace(match.Value, match.Value.Trim('[', ']'));
        }
      }
    }

    protected void BuildSPCommand(List<DataParamSource> paramList)
    {
      string[] strArray1 = Regex.Replace(Regex.Replace(this.RawText, "[\\s]+", " "), " *, *", ",").Trim().Split(' ');
      this.CommandText = strArray1.Length >= 1 ? strArray1[0] : throw new ApplicationException("명령 문장이 완전하지 않습니다.");
      if (strArray1.Length <= 1)
        return;
      string str1 = strArray1[1];
      char[] chArray1 = new char[1]{ ',' };
      foreach (string str2 in str1.Split(chArray1))
      {
        char[] chArray2 = new char[1]{ '=' };
        string[] strArray2 = str2.Split(chArray2);
        DataParameter dataParameter = this.Parameter.Add(strArray2[0]);
        foreach (DataParamSource dataParamSource in paramList)
        {
          if (strArray2[0].IsDataNameMatch(dataParamSource.Name) || strArray2[0].IsDataNameMatch(dataParamSource.ColumnName))
          {
            dataParameter.Value = !(dataParamSource.ValueProperty == (PropertyInfo) null) ? dataParamSource.ValueProperty.GetGetMethod().Invoke(dataParamSource.ValueSourceObject, (object[]) null) : dataParamSource.Value;
            break;
          }
        }
        if (strArray2[1].StartsWith("@"))
        {
          if (strArray2[1].LastIndexOf("-table-") > 0)
          {
            dataParameter.Direction = DataParameterDirection.Table;
            DataTable dataTable = dataParameter.Value.ToString().ToDataTable();
            dataTable.TableName = strArray2[0];
            dataParameter.Value = (object) dataTable;
          }
          else
            dataParameter.Direction = strArray2[1].LastIndexOf("-out-") <= 0 ? DataParameterDirection.Input : DataParameterDirection.Output;
        }
        else
        {
          dataParameter.Direction = DataParameterDirection.Input;
          dataParameter.Value = (object) strArray2[1].Trim('\'');
        }
      }
    }

    protected void WriteDataCommand()
    {
      foreach (string key in this.Parameter.Keys)
        ;
    }

    public int ExecuteNonQuery()
    {
      this.WriteDataCommand();
      return this.Agent.InternalExecuteNonQuery(this.CommandText, this.Parameter, this.UseSP);
    }

    public DataSet ExecuteDataSet()
    {
      this.WriteDataCommand();
      return this.Agent.InternalExecuteDataSet(this.CommandText, this.Parameter, this.UseSP);
    }

    public DataTable ExecuteDataTable()
    {
      this.WriteDataCommand();
      return this.Agent.InternalExecuteDataTable(this.CommandText, this.Parameter, this.UseSP);
    }

    public DataRow ExecuteDataRow()
    {
      this.WriteDataCommand();
      return this.Agent.InternalExecuteDataRow(this.CommandText, this.Parameter, this.UseSP);
    }

    public object ExecuteScalar()
    {
      this.WriteDataCommand();
      return this.Agent.InternalExecuteScalar(this.CommandText, this.Parameter, this.UseSP);
    }
  }
}
