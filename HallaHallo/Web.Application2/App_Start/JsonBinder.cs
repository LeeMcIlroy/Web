using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;

namespace HallaTube
{
    public class JsonBinderAttribute : CustomModelBinderAttribute
    {
        public string ModelName { set; get; }

        public override IModelBinder GetBinder()
        {
            return new JsonModelBinder()
            {
                ModelName = ModelName
            };
        }

        public class JsonModelBinder : IModelBinder
        {
            public string ModelName { set; get; }

            public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
            {
                string name = ModelName;
                if (string.IsNullOrEmpty(name)) name = bindingContext.ModelName;

                var json = controllerContext.HttpContext.Request.Params[name];

                if (string.IsNullOrWhiteSpace(json)) return null;
                try
                {
                    return Newtonsoft.Json.JsonConvert.DeserializeObject(json, bindingContext.ModelType);
                }
                catch (Exception ex)
                {
                    //LogManager.GetLogger().Error("DeserializeObject", ex);
                    throw ex;
                }
            }
        }
    }
}