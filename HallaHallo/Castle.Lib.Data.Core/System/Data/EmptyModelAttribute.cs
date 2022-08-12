// Decompiled with JetBrains decompiler
// Type: System.Data.EmptyModelAttribute
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;
using System.Reflection;

namespace System.Data
{
  [AttributeUsage(AttributeTargets.Class, AllowMultiple = true, Inherited = true)]
  public sealed class EmptyModelAttribute : Attribute
  {
    public static void SetEmpty(object model, Dictionary<string, bool> ModelState)
    {
      if (model == null || ((EmptyModelAttribute[]) model.GetType().GetCustomAttributes(typeof (EmptyModelAttribute), true)).Length == 0)
        return;
      foreach (PropertyInfo property in model.GetType().GetProperties())
      {
        if (property.PropertyType == typeof (string))
        {
          MethodInfo setMethod = property.GetSetMethod();
          if (!(setMethod == (MethodInfo) null) && property.GetGetMethod().Invoke(model, (object[]) null) == null)
          {
            bool flag = ModelState == null;
            if (!flag)
              flag = ModelState[property.Name];
            if (flag)
              setMethod.Invoke(model, new object[1]
              {
                (object) string.Empty
              });
          }
        }
      }
    }
  }
}
