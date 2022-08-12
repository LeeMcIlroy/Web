// Decompiled with JetBrains decompiler
// Type: Castle.Data.DataAgent
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.Data;
using System.Text.RegularExpressions;

namespace Castle.Data
{
  public abstract class DataAgent : MarshalByRefObject, IDisposable
  {
    private static Regex parameterRegex = new Regex("N?(@([a-zA-Z0-9_]+))");
    private static Regex subRegex = new Regex("\\[([@a-zA-Z0-9_]+)\\]");
    private IDataAgent dataAgent;

    public static string DefaultDBName { set; get; }

    public static int DefaultDBType { set; get; }

    public static event GetDBAgentDelegate OnGetDBAgent;

    public static event GetDBAgentExDelegate OnGetDBAgentEx;

    public virtual Regex ParameterRegex => DataAgent.parameterRegex;

    public virtual Regex SubRegex => DataAgent.subRegex;

    public static DataAgent GetDBAgent() => DataAgent.GetDBAgent(DataAgent.DefaultDBName);

    public static DataAgent GetDBAgent(string configName)
    {
      if (DataAgent.OnGetDBAgent == null)
        throw new Exception("GetDBAgentEvent 가 NULL 입니다.");
      return DataAgent.OnGetDBAgent(configName);
    }

    public static DataAgent GetDBAgentEx(int type, string connectionString)
    {
      if (DataAgent.OnGetDBAgent == null)
        throw new Exception("GetDBAgentExEvent 가 NULL 입니다.");
      return DataAgent.OnGetDBAgentEx(type, connectionString);
    }

    protected string ConnectionString { set; get; }

    public int ProvideType { protected set; get; }

    public virtual string ConvertQuery(string text) => text;

    public DataAgent() => this.dataAgent = this as IDataAgent;

    public int ExecuteNonQuery(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteNonQuery(this.ConvertQuery(commandText), dataPack, useSP);

    public DataSet ExecuteDataSet(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteDataSet(this.ConvertQuery(commandText), dataPack, useSP);

    public DataTable ExecuteDataTable(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteDataTable(this.ConvertQuery(commandText), dataPack, useSP);

    public DataRow ExecuteDataRow(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteDataRow(this.ConvertQuery(commandText), dataPack, useSP);

    public object ExecuteScalar(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteScalar(this.ConvertQuery(commandText), dataPack, useSP);

    internal int InternalExecuteNonQuery(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteNonQuery(commandText, dataPack, useSP);

    internal DataSet InternalExecuteDataSet(
      string commandText,
      DataPack dataPack = null,
      bool useSP = false)
    {
      return this.dataAgent.ExecuteDataSet(commandText, dataPack, useSP);
    }

    internal DataTable InternalExecuteDataTable(
      string commandText,
      DataPack dataPack = null,
      bool useSP = false)
    {
      return this.dataAgent.ExecuteDataTable(commandText, dataPack, useSP);
    }

    internal DataRow InternalExecuteDataRow(
      string commandText,
      DataPack dataPack = null,
      bool useSP = false)
    {
      return this.dataAgent.ExecuteDataRow(commandText, dataPack, useSP);
    }

    internal object InternalExecuteScalar(string commandText, DataPack dataPack = null, bool useSP = false) => this.dataAgent.ExecuteScalar(commandText, dataPack, useSP);

    public abstract void Dispose();

    public DataCommand GetCommand(string qryid, params object[] paramSource) => DataCommand.GetCommand(this, qryid, paramSource);
  }
}
