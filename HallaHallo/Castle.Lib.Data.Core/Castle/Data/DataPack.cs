// Decompiled with JetBrains decompiler
// Type: Castle.Data.DataPack
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Castle.Data
{
  [Serializable]
  public class DataPack : Dictionary<string, DataParameter>
  {
    private List<string> paramList = new List<string>();

    public new DataParameter this[string paramName] => this.ContainsKey(paramName) ? base[paramName] : this.Add(paramName);

    public DataParameter this[int i] => this[this.paramList[i]];

    public DataParameter Add(string paramName)
    {
      DataParameter dataParameter;
      if (this.ContainsKey(paramName))
      {
        dataParameter = this[paramName];
      }
      else
      {
        dataParameter = new DataParameter()
        {
          ParameterName = paramName
        };
        this.Add(paramName, dataParameter);
      }
      this.paramList.Add(paramName);
      return dataParameter;
    }

    public DataParameter Add(string paramName, object initValue)
    {
      DataParameter dataParameter;
      if (this.ContainsKey(paramName))
      {
        dataParameter = this[paramName];
      }
      else
      {
        dataParameter = new DataParameter()
        {
          ParameterName = paramName,
          Value = initValue
        };
        this.Add(paramName, dataParameter);
      }
      this.paramList.Add(paramName);
      return dataParameter;
    }

    public DataParameter Add(string paramName, SqlDbType type, object initValue)
    {
      DataParameter dataParameter;
      if (this.ContainsKey(paramName))
      {
        dataParameter = this[paramName];
      }
      else
      {
        dataParameter = new DataParameter()
        {
          ParameterName = paramName,
          SqlType = new SqlDbType?(type),
          Value = initValue
        };
        this.Add(paramName, dataParameter);
      }
      this.paramList.Add(paramName);
      return dataParameter;
    }

    public T[] ToDbParameter<T>() where T : DbParameter, new()
    {
      int count = this.paramList.Count;
      int index = 0;
      T[] objArray = new T[count];
      foreach (string paramName in this.paramList)
      {
        DataParameter dataParameter = this[paramName];
        T obj = new T();
        obj.ParameterName = dataParameter.ParameterName;
        switch (dataParameter.Direction)
        {
          case DataParameterDirection.Input:
            obj.Direction = ParameterDirection.Input;
            break;
          case DataParameterDirection.Output:
            obj.Direction = ParameterDirection.Output;
            break;
          default:
            obj.Direction = ParameterDirection.InputOutput;
            break;
        }
        if (dataParameter.Size > 0)
          obj.Size = dataParameter.Size;
        object realValue = dataParameter.Value;
        SqlDbType? sqlType = dataParameter.SqlType;
        if (sqlType.HasValue)
        {
          // ISSUE: variable of a boxed type
          __Boxed<T> local = (__Boxed<T>)(object) obj;
          sqlType = dataParameter.SqlType;
          int dbType = (int) DataPack.ToDbType(sqlType.Value, ref realValue);
          local.DbType = (DbType) dbType;
        }
        else if (dataParameter.Type != (Type) null)
          obj.DbType = DataPack.ToDbType(dataParameter.Type, ref realValue);
        if (realValue != null)
        {
          DateTime? nullable = realValue as DateTime?;
          if (!nullable.HasValue)
          {
            if (obj.DbType == DbType.DateTime)
              realValue = (object) DateTime.Parse(realValue.ToString());
          }
          else if (!nullable.Value.IsValid())
            realValue = (object) null;
        }
        obj.Value = realValue;
        objArray[index] = obj;
        ++index;
      }
      return objArray;
    }

    private static DbType ToDbType(SqlDbType type, ref object realValue)
    {
      DbType dbType = DbType.AnsiString;
      switch (type)
      {
        case SqlDbType.BigInt:
          dbType = DbType.Int64;
          break;
        case SqlDbType.Binary:
          dbType = DbType.Binary;
          break;
        case SqlDbType.Bit:
          dbType = DbType.Boolean;
          realValue = (object) (realValue.ToBool() ? 1 : 0);
          break;
        case SqlDbType.Char:
          dbType = DbType.AnsiStringFixedLength;
          break;
        case SqlDbType.DateTime:
          dbType = DbType.DateTime;
          break;
        case SqlDbType.Decimal:
          dbType = DbType.Decimal;
          break;
        case SqlDbType.Int:
          dbType = DbType.Int32;
          break;
        case SqlDbType.NChar:
          dbType = DbType.StringFixedLength;
          break;
        case SqlDbType.NVarChar:
          dbType = DbType.String;
          break;
        case SqlDbType.SmallInt:
          dbType = DbType.Int16;
          break;
      }
      return dbType;
    }

    private static DbType ToDbType(Type type, ref object realValue)
    {
      DbType dbType = DbType.AnsiString;
      if (type.Equals(typeof (string)))
        dbType = DbType.AnsiString;
      else if (type.Equals(typeof (short)))
        dbType = DbType.Int16;
      else if (type.Equals(typeof (int)))
        dbType = DbType.Int32;
      else if (type.Equals(typeof (long)))
        dbType = DbType.Int64;
      else if (type.Equals(typeof (DateTime)))
        dbType = DbType.DateTime;
      else if (type.Equals(typeof (bool)))
      {
        dbType = DbType.Boolean;
        realValue = (object) (realValue.ToBool() ? 1 : 0);
      }
      else if (type.Equals(typeof (double)))
        dbType = DbType.Double;
      else if (type.Equals(typeof (float)))
        dbType = DbType.Single;
      else if (type.Equals(typeof (byte)))
        dbType = DbType.Byte;
      else if (type.Equals(typeof (byte[])))
        dbType = DbType.Binary;
      return dbType;
    }

        private class __Boxed<T> where T : DbParameter, new()
        {
            public DbType DbType { get; internal set; }
        }
    }

}
