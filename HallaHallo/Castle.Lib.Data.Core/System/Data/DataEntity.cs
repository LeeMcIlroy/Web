// Decompiled with JetBrains decompiler
// Type: System.Data.DataEntity
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;

namespace System.Data
{
  public class DataEntity : DataModel, IEntityDataRow
  {
    [NonSerialized]
    private DataRow _Data;

    public object this[string key] => this._Data == null ? (object) null : this._Data[key];

    public void SetEntityData(DataRow data) => this._Data = data;

    public DataRow GetEntityData() => this._Data != null ? this._Data : throw new ApplicationException("데이터가 설정되지 않았습니다.");

    public Dictionary<string, bool> ValidState { set; get; }
  }
}
