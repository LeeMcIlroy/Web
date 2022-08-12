using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace System.Xml
{
    public static class XmlExtension
    {
        public static XmlNode SetCData(this XmlDocument xml, string path, string val)
        {
            XmlNode node = xml.SelectSingleNode(path);
            node.AppendChild(xml.CreateCDataSection(val));
            return node;
        }
    }
}

