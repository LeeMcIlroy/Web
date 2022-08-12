// Decompiled with JetBrains decompiler
// Type: System.Data.DataRowExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Reflection;

namespace System.Data
{
  public static class DataRowExtension
  {
    public static T GetEntity<T>(this DataRow dr) => dr.GetEntity<T>((object) null);

    public static T GetEntity<T>(this DataRow dr, object entity)
    {
      Type type = typeof (T);
      switch (entity)
      {
        case null:
        case T _:
          if (dr == null)
            return entity == null ? default (T) : (T) entity;
          T obj = entity == null ? (T) type.Assembly.CreateInstance(type.FullName) : (T) entity;
          if (obj is IEntityDataRow entityDataRow)
            entityDataRow.SetEntityData(dr);
          DataRowExtension.SetValue(dr, type, (object) obj);
          foreach (PropertyInfo property in type.GetProperties())
          {
            Type propertyType = property.PropertyType;
            if (propertyType.IsSubclassOf(typeof (DataEntity)))
            {
              MethodInfo setMethod = property.GetSetMethod();
              if (setMethod != (MethodInfo) null)
              {
                object instance = propertyType.Assembly.CreateInstance(propertyType.FullName);
                setMethod.Invoke((object) obj, new object[1]
                {
                  instance
                });
                //if (instance is IEntityDataRow entityDataRow)
                //  entityDataRow.SetEntityData(dr);
                DataRowExtension.SetValue(dr, instance.GetType(), instance);
              }
            }
          }
          return obj;
        default:
          return default (T);
      }
    }

    private static void SetValue(DataRow dr, Type type, object rtn)
    {
      foreach (PropertyInfo property in type.GetProperties())
      {
        string src = property.Name;
        ColumnNameAttribute[] customAttributes = (ColumnNameAttribute[]) property.GetCustomAttributes(typeof (ColumnNameAttribute), false);
        if (customAttributes.Length != 0)
          src = customAttributes[0].ColumnName;
        string columnName = string.Empty;
        foreach (DataColumn column in (InternalDataCollectionBase) dr.Table.Columns)
        {
          if (src.IsDataNameMatch(column.ColumnName))
          {
            columnName = column.ColumnName;
            break;
          }
        }
        if (!string.IsNullOrEmpty(columnName))
        {
          MethodInfo setMethod = property.GetSetMethod();
          MethodInfo getMethod = property.GetGetMethod();
          object obj = dr[columnName];
          if (dr[columnName] is DBNull)
          {
            if (getMethod.ReturnType == typeof (string))
            {
              obj = (object) string.Empty;
            }
            else
            {
              if (!(getMethod.ReturnType == typeof (DateTime)))
                throw new Exception(property.Name + "에 DBNull 데이터를 매핑할 수 없습니다.");
              obj = (object) DateTime.MinValue;
            }
          }
          else if (getMethod.ReturnType == typeof (int))
          {
            int result;
            if (int.TryParse(obj.ToString(), out result))
              obj = (object) result;
          }
          else if (getMethod.ReturnType == typeof (float))
          {
            float result;
            if (float.TryParse(obj.ToString(), out result))
              obj = (object) result;
          }
          else if (getMethod.ReturnType == typeof (double))
          {
            double result;
            if (double.TryParse(obj.ToString(), out result))
              obj = (object) result;
          }
          else if (getMethod.ReturnType == typeof (string) && obj != null)
            obj = (object) obj.ToString();
          if (!(setMethod == (MethodInfo) null))
            setMethod.Invoke(rtn, new object[1]{ obj });
        }
      }
    }
  }
}
