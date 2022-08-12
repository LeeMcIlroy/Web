// Decompiled with JetBrains decompiler
// Type: Castle.Data.EmptyDBAgent
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.Data;

namespace Castle.Data
{
  public class EmptyDBAgent : DataAgent, IDataAgent
  {
    int IDataAgent.ExecuteNonQuery(string commandText, DataPack dataPack, bool useSP) => throw new NotImplementedException();

    DataSet IDataAgent.ExecuteDataSet(
      string commandText,
      DataPack dataPack,
      bool useSP)
    {
      throw new NotImplementedException();
    }

    DataTable IDataAgent.ExecuteDataTable(
      string commandText,
      DataPack dataPack,
      bool useSP)
    {
      throw new NotImplementedException();
    }

    object IDataAgent.ExecuteScalar(string commandText, DataPack dataPack, bool useSP) => throw new NotImplementedException();

    DataRow IDataAgent.ExecuteDataRow(
      string commandText,
      DataPack dataPack,
      bool useSP)
    {
      throw new NotImplementedException();
    }

    public override void Dispose()
    {
    }
  }
}
