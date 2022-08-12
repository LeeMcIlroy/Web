// Decompiled with JetBrains decompiler
// Type: System.Data.DataRepository
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using Castle.Data;
using System.Collections;
using System.Transactions;

namespace System.Data
{
  public class DataRepository : MarshalByRefObject, IDisposable
  {
    protected TransactionOptions tranOption;
    private DataAgent agent;

    public DataRepository()
    {
      this.tranOption = new TransactionOptions();
      this.tranOption.IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted;
      this.tranOption.Timeout = new TimeSpan(0, 0, 30);
      this.SetDBAgent(DataAgent.DefaultDBName);
    }

    protected void SetDBAgent(string configName) => this.agent = DataAgent.GetDBAgent(configName);

    protected void SetDBAgentEx(int type, string connectionString) => this.agent = DataAgent.GetDBAgentEx(type, connectionString);

    public DataCommand GetCommand(string qryid, params object[] paramSource) => DataCommand.GetCommand(this.agent, qryid, paramSource);

    private int _ExecuteNonQuery(string qryid, object param = null) => DataCommand.GetCommand(this.agent, qryid, param).ExecuteNonQuery();

    protected int ExecuteNonQuery(string qryid, object param = null)
    {
      if (!(param is IEnumerable enumerable))
        return this._ExecuteNonQuery(qryid, param);
      int num = 0;
      foreach (object obj in enumerable)
        num += this._ExecuteNonQuery(qryid, obj);
      return num;
    }

    protected DataSet ExecuteDataSet(string qryid, object param = null) => this.agent.GetCommand(qryid, param).ExecuteDataSet();

    protected DataTable ExecuteDataTable(string qryid, object param = null) => this.agent.GetCommand(qryid, param).ExecuteDataTable();

    protected object ExecuteScalar(string qryid, object param = null) => this.agent.GetCommand(qryid, param).ExecuteScalar();

    protected DataRow ExecuteDataRow(string qryid, object param = null) => this.agent.GetCommand(qryid, param).ExecuteDataRow();

    public void Dispose() => this.agent = (DataAgent) null;
  }
}
