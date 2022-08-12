using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;
namespace HallaTube
{
    [System.Web.Mvc.ModelBinder(typeof(ArrayBinder))]
    public class AList<T> : List<T>
    {

    }
    public class ArrayBinder : IModelBinder
    {

        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            object model = null;
            if (bindingContext.ModelType.GetInterface("IList") != null)
            {
                string prefix = bindingContext.ModelName;
                string entityname = bindingContext.ModelType.FullName.Replace(bindingContext.ModelType.FullName.Split('[')[0], string.Empty).Trim('[', ']');
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

                int idx = 0;
                while (true)
                {
                    object entity = entityType.Assembly.CreateInstance(entityType.FullName);
                    bool hasValue = false;
                    foreach (var prop in entityType.GetProperties())
                    {
                        string key = prefix + "." + prop.Name;
                        var val = bindingContext.ValueProvider.GetValue(key);
                        if (val != null && !string.IsNullOrEmpty(val.AttemptedValue))
                        {
                            hasValue = true;
                            bindingContext.ModelState.SetModelValue(key, val);

                            object[] rawvalue = val.RawValue as object[];
                            if (rawvalue.Length <= idx)
                            {
                                hasValue = false;
                                break;
                            }

                            try
                            {
                                if (rawvalue[idx] is HttpPostedFileWrapper)
                                {
                                    prop.GetSetMethod().Invoke(entity, new object[] { rawvalue[idx] });
                                }
                                else
                                {
                                    object modelvalue = Convert.ChangeType(rawvalue[idx], prop.PropertyType);
                                    prop.GetSetMethod().Invoke(entity, new object[] { modelvalue });
                                }

                            }
                            catch
                            {

                            }
                        }
                    }
                    if (!hasValue) break;
                    list.Add(entity);
                    idx++;
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