// Decompiled with JetBrains decompiler
// Type: System.ObjectExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;
using System.ComponentModel;
using System.Linq.Expressions;
using System.Reflection;

namespace System
{
  public static class ObjectExtension
  {
    private static Dictionary<Type, Action<object>> _typesInitializers = new Dictionary<Type, Action<object>>();

    public static string ToMoney(this object obj)
    {
      switch (obj)
      {
        case string _:
          string s = obj as string;
          return s == "0" ? "0" : int.Parse(s).ToString("#,#");
        case int num:
          return num == 0 ? "0" : num.ToString("#,#");
        default:
          return "0";
      }
    }

    public static string ToDate(this object obj, string format = "yyyy-MM-dd")
    {
      switch (obj)
      {
        case string _:
          try
          {
            return string.IsNullOrEmpty(format) ? DateTime.Parse((string) obj).ToString("yyyy-MM-dd") : DateTime.Parse((string) obj).ToString(format);
          }
          catch
          {
            break;
          }
        case DateTime dt:
          if (dt.IsValid())
            return ((DateTime) obj).ToString(format);
          break;
      }
      return string.Empty;
    }

    public static DateTime ToDateTime(this string str)
    {
      DateTime result;
      if (!DateTime.TryParse(str, out result))
        result = DateTime.MinValue;
      return result;
    }

    public static DateTime ToDateTime(this string str, DateTime defaultValue)
    {
      DateTime result;
      if (!DateTime.TryParse(str, out result))
        result = defaultValue;
      return result;
    }

    public static bool ToBool(this object obj, bool defaultvalue = false)
    {
      try
      {
        return bool.Parse(obj.ToString());
      }
      catch
      {
        return defaultvalue;
      }
    }

    public static void ApplyDefaultValues(this object _this)
    {
      Action<object> action = (Action<object>) null;
      if (!ObjectExtension._typesInitializers.TryGetValue(_this.GetType(), out action))
      {
        action = (Action<object>) (o => {});
        ParameterExpression parameterExpression = Expression.Parameter(typeof (object), "this");
        foreach (PropertyInfo property in _this.GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
          if (property.CanWrite && property.GetCustomAttributes(typeof (DefaultValueAttribute), false) is DefaultValueAttribute[] customAttributes && customAttributes.Length != 0)
          {
            Expression expression1 = (Expression) Expression.Convert((Expression) Expression.Constant(customAttributes[0].Value), property.PropertyType);
            Expression<Action<object>> expression2 = Expression.Lambda<Action<object>>((Expression) Expression.Call((Expression) Expression.TypeAs((Expression) parameterExpression, _this.GetType()), property.GetSetMethod(), expression1), parameterExpression);
            action += expression2.Compile();
          }
        }
        if (!ObjectExtension._typesInitializers.ContainsKey(_this.GetType()))
          ObjectExtension._typesInitializers.Add(_this.GetType(), action);
      }
      action(_this);
    }

    public static void ResetDefaultValues(this object _this)
    {
      Action<object> action = (Action<object>) null;
      if (!ObjectExtension._typesInitializers.TryGetValue(_this.GetType(), out action))
      {
        action = (Action<object>) (o => {});
        foreach (PropertyDescriptor property in TypeDescriptor.GetProperties(_this))
        {
          if (property.CanResetValue(_this))
            action += new Action<object>(property.ResetValue);
        }
        ObjectExtension._typesInitializers.Add(_this.GetType(), action);
      }
      action(_this);
    }
  }
}
