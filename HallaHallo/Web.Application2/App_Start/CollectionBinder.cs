using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;

namespace HallaTube
{
    public class CollectionBinder : IModelBinder
    {

        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            object model = null;
            if (bindingContext.ModelType.GetInterface("IList") != null)
            {
                string prefix = bindingContext.ModelName;
                string entityname = bindingContext.ModelType.FullName.Replace("System.Collections.Generic.List`1", string.Empty).Trim('[', ']');
                if (bindingContext.Model != null)
                {
                    model = bindingContext.Model;
                }
                else
                {
                    model = bindingContext.ModelType.Assembly.CreateInstance(bindingContext.ModelType.FullName);
                }
                IList list = model as IList;
                list.Clear();

                Type entityType = Type.GetType(entityname);

                int max = 0;
                foreach (var prop in entityType.GetProperties())
                {
                    string key = prefix + "." + prop.Name;
                    var val = bindingContext.ValueProvider.GetValue(key);
                    if (val != null && !string.IsNullOrEmpty(val.AttemptedValue))
                    {
                        if (max == 0)
                        {
                            max = ((string[])val.RawValue).Length;
                        }
                        bindingContext.ModelState.SetModelValue(key, val);
                    }
                }

                for (int i = 0; i < max; i++)
                {
                    object entity = entityType.Assembly.CreateInstance(entityType.FullName);
                    foreach (var prop in entityType.GetProperties())
                    {
                        string key = prefix + "." + prop.Name;
                        if (!bindingContext.ModelState.ContainsKey(key)) continue;

                        var valueProvider = bindingContext.ModelState[key].Value;
                        string[] rawvalue = (string[])valueProvider.RawValue;
                        
                        string val = rawvalue[i];
                        prop.GetSetMethod().Invoke(entity, new object[] { val });
                    }
                    list.Add(entity);
                }
            }
            else
            {
                DefaultModelBinder binder = new DefaultModelBinder();
                model = binder.BindModel(controllerContext, bindingContext);
            }
            return model;

        }
    }
}