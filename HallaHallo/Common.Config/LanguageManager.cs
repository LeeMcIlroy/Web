using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace HallaTube
{
    public class LanguageManager
    {
        static Dictionary<string, List<string>> _resource = null;
        public static void Load(string path, string pattern= "*.json")
        {
            try
            {
                var files = System.IO.Directory.GetFiles(path, pattern, SearchOption.TopDirectoryOnly);
                Dictionary<string, List<string>> newResource = null;

                for (int i = 0; i < files.Length; i++)
                {
                    string file = files[i];

                    string json = System.IO.File.ReadAllText(file);
                    var temp = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(json);
                    if (newResource == null)
                    {
                        newResource = temp;
                    }
                    else
                    {
                        foreach (string key in temp.Keys)
                        {
                            if (newResource.ContainsKey(key))
                            {
                                newResource[key] = temp[key];
                            }
                            else
                            {
                                newResource.Add(key, temp[key]);
                            }
                        }
                    }

                }

                _resource = newResource;

            }
            catch (Exception ex)
            {
                if (_resource == null)
                {
                    System.Threading.Thread.Sleep(1000);
                }
                else
                {
                    Load(path);
                }
            }
            finally
            {
                new System.Threading.Thread(() =>
                {
                    var watcher = new FileSystemWatcher();
                    FileInfo fi = new FileInfo(path);
                    watcher.Path = fi.Directory.FullName;
                    watcher.IncludeSubdirectories = true;
                    //watcher.Filter = fi.Name;
                    watcher.EnableRaisingEvents = true;
                    var result = watcher.WaitForChanged(WatcherChangeTypes.Changed);
                    System.Threading.Thread.Sleep(100);
                    Load(path);
                }).Start();
            }
        }

        public static Dictionary<string, LanguageManager> Instance { private set; get; }
        public static void Initialize()
        {
            Instance = new Dictionary<string, LanguageManager>(LanguageType.GetCodeList().Count);
            foreach (string item in LanguageType.GetCodeList().Values)
            {
                Instance.Add(item, new LanguageManager(item));
            }
        }

        protected string lang;
        protected int langOrder;
        public string Language => lang;

        private LanguageManager(string lang)
        {
            this.lang = lang;
            langOrder = LanguageType.GetOrder(lang);
        }


        public string this[string key, Dictionary<string, string> data = null]
        {
            get
            {
                return this[key, lang, data];
            }
        }

        public string this[string key, string code, Dictionary<string, string> data = null]
        {
            get
            {
                return Get(key, LanguageType.GetOrder(code), data) ?? key;
            }
        }

        public string this[string key, object data]
        {
            get
            {
                return this[key, lang, data];
            }
        }

        public string this[string key, string code, object data]
        {
            get
            {
                var targetType = data.GetType();
                var props = targetType.GetProperties();
                var dic = new Dictionary<string, string>(props.Length);
                foreach (PropertyInfo prop in props)
                {
                    dic.Add(prop.Name, prop.GetValue(data).ToString());
                }

                return this[key, code, dic];
            }
        }

        public string Get(string key, Dictionary<string, string> data = null)
        {
            return Get(key, langOrder, data);
        }

        private string Get(string key, int order, Dictionary<string, string> data)
        {
            if (_resource == null) return null;
            var item = _resource.SafeGet(key);
            if (item == null) return null;
            if (item.Count <= order) return null;
            string text = item[order];

            var matches = Regex.Matches(text, @"\[[^\]]+\]");
            foreach (Match m in matches)
            {
                string val = m.Value;
                var name = val.Substring(1, val.Length - 2);
                var info = name.Split(',');
                if (info.Length == 1)
                {
                    text = text.Replace(val, data[name]);
                }
                else
                {
                    var word = data[info[0]];
                    var post = info[1];

                    if (hasFinal(word))
                    {
                        switch (post)
                        {
                            case "를":
                                post = "을";
                                break;
                            case "가":
                                post = "이";
                                break;
                            case "는":
                                post = "은";
                                break;
                            case "와":
                                post = "과";
                                break;
                        }
                    }
                    else
                    {
                        switch (post)
                        {
                            case "을":
                                post = "를";
                                break;
                            case "이":
                                post = "가";
                                break;
                            case "은":
                                post = "는";
                                break;
                            case "과":
                                post = "와";
                                break;
                        }
                    }
                    text = text.Replace(val, word + post);
                }
            }

            return text;
        }

        private bool hasFinal(string word)
        {
            int code = word[word.Length - 1] - 44032;

            if (code < 0 || code > 11171) return false;

            if (code % 28 == 0) return false;
            else return true;
        }


    }
}
