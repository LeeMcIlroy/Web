// Decompiled with JetBrains decompiler
// Type: Castle.Data.IDataAgent
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Data;

namespace Castle.Data
{
  public interface IDataAgent
  {
    int ExecuteNonQuery(string commandText, DataPack dataPack, bool useSP);

    DataSet ExecuteDataSet(string commandText, DataPack dataPack, bool useSP);

    DataTable ExecuteDataTable(string commandText, DataPack dataPack, bool useSP);

    DataRow ExecuteDataRow(string commandText, DataPack dataPack, bool useSP);

    object ExecuteScalar(string commandText, DataPack dataPack, bool useSP);
  }
}
