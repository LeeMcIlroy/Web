(function(){function q(a){var d={};a=a.split(",");for(var c=0;c<a.length;c++)d[a[c]]=!0;return d}var v=50,x=",span,strong,b,",t=/^<([-A-Za-z0-9_]+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,y=/^<\/([-A-Za-z0-9_:@.]+)[^>]*>/,A=/([-A-Za-z0-9_]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g,u=/^<([-A-Za-z0-9_:-]+)((?:\s+[a-zA-Z_0-9:-]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,B=/([-A-Za-z0-9_:-]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g,
C=q("colgroup,col"),D=q("area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed");q("area,base,basefont,br,col,frame,img,input,isindex,link,meta,param,embed");var E=q("address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,hr,iframe,ins,isindex,li,map,menu,noframes,noscript,object,ol,p,pre,script,table,tbody,td,tfoot,th,thead,tr,ul,h1,h2,h3,h4,h5,h6,figure,nav,section,article"),z=!1,l="a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,select,small,span,strike,strong,sub,sup,textarea,tt,u,var",
w=q(l),F=q("colgroup,dd,dt,li,options,p,td,tfoot,th,thead,tr"),G=q("checked,compact,declare,defer,disabled,ismap,multiple,nohref,noresize,noshade,nowrap,readonly,selected"),H=q("");"undefined"==typeof DEXT5_EDITOR&&(DEXT5_EDITOR={});DEXT5_EDITOR.HTMLParser=function(a,d,c){function h(a,b,e,d){b=b.toLowerCase();if(E[b]){for("table"!=k.last()&&"tbody"!=k.last()||"td"!=b||h("","tr","","");k.last()&&w[k.last()];)g("",k.last());"p"!=k.last()||"table"!=b&&"hr"!=b&&"center"!=b&&"figure"!=b||g("","p")}F[b]&&
k.last()==b&&g("",b);(d=D[b]||!!d)||k.push(b);if(c.start){var f=[];a=t.test(a)?A:B;e.replace(a,function(a,b,e,c,d){e=e?e:c?c:d?d:G[b]?b:"";c="";""!=a&&(a=a.substring(a.indexOf(b)+b.length),a=a.substring(a.indexOf("=")+1),a=a.replace(/^\s+/,""),c=a.substring(0,1),"'"!=c&&'"'!=c&&(c=""));f.push({name:b,value:e,escaped:e.replace(/(^|[^\\])"/g,'$1\\"'),quotationmark:c})});c.start&&c.start(b,f,d)}}function g(a,b){if(b)for(b=b.toLowerCase(),e=k.length-1;0<=e&&k[e]!=b;e--);else var e=0;if(0<=e){for(var d=
k.length-1;d>=e;d--)c.end&&c.end(k[d]);k.length=e}}var b,e,k=[],l=a;for(k.last=function(){return this[this.length-1]};a;){e=!0;if(k.last()&&H[k.last()])a=a.replace(new RegExp("(.*)</"+k.last()+"[^>]*>"),function(a,b){b=b.replace(/\x3c!--(.*?)--\x3e/g,"$1").replace(/<!\[CDATA\[(.*?)]]\x3e/g,"$1");c.chars&&c.chars(b);return""}),g("",k.last());else{var m=a.indexOf("<");b=a.indexOf(">")+1;var p=a.substring(m,b);if(0==a.indexOf("\x3c!--"))b=a.indexOf("--\x3e"),0<=b&&(c.comment&&("style"==k.last()?c.comment(a.substring(4,
b),!0):c.comment(a.substring(4,b))),a=a.substring(b+3),e=!1);else if(0==a.toLowerCase().indexOf("<?xml"))b=a.indexOf("/>"),0<=b&&(a=a.substring(b+2),e=!1);else if(0!=a.indexOf("<")&&"</"+k.last()+">"==p.replace(/ /ig,""))e=a.substring(0,m),a=a.substring(b),a=e+"</"+k.last()+">"+a,e=!0;else if(0==a.indexOf("</")){if(b=a.match(y))a=a.substring(b[0].length),b[0].replace(y,g),e=!1}else if(0==a.indexOf("<"))if(b=a.match(t))a=a.substring(b[0].length),b[0].replace(t,h),e=!1;else if(b=a.match(u))a=a.substring(b[0].length),
b[0].replace(u,h),e=!1;else{if("1"==DEXTTOP.G_CURREDITOR._config.removeIncorrectAttribute&&(b=a.indexOf("<"),p=a.indexOf(">"),0==b&&0<p)){var f=a.substring(0,p+1),r=m=b=0;0<f.indexOf('\ub9d1\uc740=""')?(b=f.indexOf('\ub9d1\uc740=""'),m=5,r=f.split('\ub9d1\uc740=""').length):0<f.indexOf("\ub9d1\uc740=''")&&(b=f.indexOf("\ub9d1\uc740=''"),m=5,r=f.split("\ub9d1\uc740=''").length);if(2==r&&0<b&&(p=a.substring(p+1),r=f.substring(0,b).lastIndexOf(" "),r<b+m))if(a=f.substring(r,b+m),f=f.replace(a,""),a=
f+p,b=a.match(t))a=a.substring(b[0].length),b[0].replace(t,h),e=!1;else if(b=a.match(u))a=a.substring(b[0].length),b[0].replace(u,h),e=!1}m=/^<([-a-zA-Z._]*@[-a-zA-Z._]*)()>/;if(b=a.match(m))a=a.substring(b[0].length),b[0].replace(m,h),e=!1}e&&(b=a.indexOf("<"),e=0>b?a:a.substring(0,b),a=0>b?"":a.substring(b),c.chars&&(k.last()&&w[k.last()]&&"textarea"!=k.last()&&"script"!=k.last()&&0>k.indexOf("pre")&&0>k.indexOf("xmp")&&(b=!1,m=RegExp("\\S\\n","g"),m.test(e)&&(b=!0),m=RegExp("\\n\\S","g"),m.test(e)&&
(b=!0),m=RegExp("\\S\\n\\S","g"),m.test(e)&&(b=!0),b?e=e.replace(/\n/g," "):(m=RegExp("\\n\\n","g"),m.test(e)&&""==e.trim()?e=e.replace(/\n\n/g,""):e==unescape("%20%20")&&(b=new RegExp(unescape("%20"),"g"),e=e.replace(b,"&nbsp;")))),"1"==DEXTTOP.G_CURREDITOR._config.replaceSpace&&d&&(b=new RegExp(unescape("%20%20"),"g"),e=e.replace(b,"&nbsp; ")),c.chars(e)))}if(a==l)throw"Parse Error: "+a;l=a}g()};DEXT5_EDITOR.HTMLParser.HTMLtoXML=function(a,d){var c="",h=DEXTTOP.G_CURREDITOR._config.skipTagInParser;
if(""!=h&&0==z){l=l.replace(/,/g,",,");l=","+l+",";for(var h=h.split(","),g=h.length,b=0;b<g;b++)l=l.replace(","+h[b]+",","");l=l.replace(/,,/g,",");l=l.replace(/^,/g,"");l=l.replace(/,$/g,"");w=q(l);z=!0}DEXT5_EDITOR.HTMLParser(a,d,{start:function(a,b,d){c+="<"+a;for(a=0;a<b.length;a++)c="href"==b[a].name||"src"==b[a].name?c+(" "+b[a].name+"="+b[a].quotationmark+b[a].value+b[a].quotationmark):""!=b[a].quotationmark?c+(" "+b[a].name+"="+b[a].quotationmark+b[a].value+b[a].quotationmark):c+(" "+b[a].name+
'="'+b[a].escaped+'"');c+=(d?"/":"")+">"},end:function(a){C[a]||(c+="</"+a+">")},chars:function(a){c+=a},comment:function(a,b){c="0"==DEXTTOP.G_CURREDITOR._config.removeComment||b?c+("\x3c!--"+a+"--\x3e"):c+""}});return c};DEXT5_EDITOR.HTMLParser.RemoveOfficeTag=function(a,d){if(""==a||void 0==a)return"";a=DEXT5_EDITOR.HTMLParser.RemoveOfficeTag2(a);a=DEXTTOP.DEXT5.util.replaceOneSpaceToNbsp(a);d&&(a=a.replace(/(<span[^>]*>)\s<\/span>/gi,"$1&nbsp;</span>"),a=a.replace(/>\s+</g,"><"));return a};DEXT5_EDITOR.HTMLParser.RemoveOfficeTag2=
function(a){var d=RegExp("<o:p></o:p>","gi");a=a.replace(d,"");d=RegExp("<o:p>\\s+</o:p>","gi");a=a.replace(d,"");d=RegExp("<o:p ([^>]+)></o:p>","gi");a=a.replace(d,"");d=RegExp("<o:p ([^>]+)>\\s+</o:p>","gi");a=a.replace(d,"");d=RegExp("<w:sdt[^>]*>","gi");a=a.replace(d,"");d=RegExp("</w:sdt>","gi");a=a.replace(d,"");"1"==DEXTTOP.G_CURREDITOR._config.removeLangAttribute&&(d=RegExp('(<[^>]+)(lang=["]?en-us["])([^>]*>)',"gi"),d.test(a)&&(a=a.replace(d,"$1$3")));"1"==DEXTTOP.G_CURREDITOR._config.removeMsoClass&&
(d=RegExp('(<[^>]+\\sclass=[\\"]?)(mso\\w+)([\\"]?[^>]*>)',"gi"),d.test(a)&&(a=a.replace(d,"$1$3")));d=RegExp("(<[^>]+)(mso-ascii-font-family\\s*:\\s*(&quot;)?[a-z\u3131-\ud7a3 ]*(&quot;)?;?)([^>]*>)","gi");d.test(a)&&(a=a.replace(d,"$1$5"));d=RegExp("<v:shapetype ([^>]+)>[\\s\\S]*?</v:shapetype>","gi");a=a.replace(d,"");d=RegExp("<v:shape [^>]+>[\\s\\S]*?(<img [^>]+>)*?</v:shape>","gi");a=a.replace(d,"$1");d=RegExp("<v:shape ([^>]+)>[\\s\\S]*?</v:shape>","gi");a=a.replace(d,"");return a=a.replace(/<\!\[if ppt\]>/gi,
"")};DEXT5_EDITOR.HTMLParser.CheckNeedNestedHTML=function(a,d,c){var h=!1;"undefined"!=typeof d&&""!=d&&(v=d);d=[];var g="p";"undefined"!=typeof c&&""!=c&&(g=c);c=g.split(",");var b=c.length;if(1<b)for(g=0;g<b;g++){var e=a.getElementsByTagName(c[g]);try{d=d.concat(Array.prototype.slice.call(e,0))}catch(k){for(var l=e.length,m=0;m<l;m++)d.push(e[m])}}else d=a.getElementsByTagName(g);g=0;for(a=d.length;g<a;g++)if(DEXT5_EDITOR.HTMLParser.GetChildrenCount(d[g],!0)>v){h=!0;break}return h};DEXT5_EDITOR.HTMLParser.GetChildrenCount=
function(a,d){var c=0;a.childNodes&&(c=DEXT5_EDITOR.HTMLParser.getChildrenCountForNestedHTML(a,d)-a.childNodes.length);return c};DEXT5_EDITOR.HTMLParser.getChildrenCountForNestedHTML=function(a,d){for(var c=0,h=a.childNodes.length,g=0;g<h;g++)1==a.childNodes[g].nodeType&&-1<x.indexOf(","+a.childNodes[g].tagName.toLowerCase()+",")&&(d&&(c+=DEXT5_EDITOR.HTMLParser.getChildrenCountForNestedHTML(a.childNodes[g],d)),c++);return c};DEXT5_EDITOR.HTMLParser.CleanNestedHtml=function(a,d,c,h,g){function b(a){for(var b=
"",c=Array(a.childNodes.length),d=0;d<c.length;d++){c[d]=[];c[d].push(a.childNodes[d]);e(a.childNodes[d],c[d]);var g=d,f=c[d],k=[],h=0;a:for(;h<f.length;h++){for(var m=0;m<k.length;m++)if(k[m]==f[h])continue a;k[k.length]=f[h]}c[g]=k;b+=c[d].join("")}return b}function e(a,b){for(var d=a.childNodes,c=0;c<d.length;c++)b.push(d[c]),d[c].hasChildNodes()&&1==d[c].nodeType&&"table"!=d[c].nodeName.toLowerCase()&&e(d[c],b);for(var d=0,f;d<b.length;d++){c=b[d];if(1==c.nodeType)if("table"==c.nodeName.toLowerCase())c=
c.outerHTML;else{f=c.nodeName;if(-1==(" "+m.join(" ").toUpperCase()+" ").search(" "+f.toUpperCase()+" ")){b.splice(d,1);d--;continue}f=c;for(var g="",h=0,l=void 0;h<f.attributes.length;h++)l=f.attributes[h],1==l.specified&&("style"==l.name?(l=k(f),""!=l&&(g+=' style="'+k(f)+'"')):""!=l.value&&(g+=" "+l.name+'="'+l.value+'"'));f=g;c="<"+c.nodeName.toLowerCase()+f+">"}else 3==c.nodeType&&(c=c.nodeValue.replace(/\n/g,""),c=c.replace(/(\s)\s+/g,"$1"),c=c.replace(/</g,"&lt;"),c=c.replace(/>/g,"&gt;"));
b[d]=c}return b}function k(a){for(var b="",c=0,d=l.length,e;c<d;c++)a.currentStyle?e=a.currentStyle[l[c]]:window.getComputedStyle&&(e=document.defaultView.getComputedStyle(a,null).getPropertyValue(l[c])),b+=l[c]+":"+e+";";return b}var l=[],m="p div a abbr acronym applet basefont bdo big br button cite code del dfn em font i iframe img input ins kbd label map object q s samp script select small strike sub sup textarea tt u var".split(" ");if(""!=a._config.cleanNestedTagOptions.removeTag){for(var p=
a._config.cleanNestedTagOptions.removeTag.split(","),f=p.length-1;0<=f;f--){var r=m.indexOf(p[f]);-1<r&&m.splice(r,1)}x=","+a._config.cleanNestedTagOptions.removeTag+","}0<a._config.cleanNestedTagOptions.allowStyle.length&&(l=a._config.cleanNestedTagOptions.allowStyle);"undefined"!=typeof c&&""!=c&&(v=parseInt(c));f="p";"undefined"!=typeof h&&""!=h&&(f=h);h=a._DOC;"undefined"!=typeof g&&""!=g&&(h=g);var n=[];g=f.split(",");c=g.length;if(1<c)for(f=0;f<c;f++){p=h.getElementsByTagName(g[f]);try{n=n.concat(Array.prototype.slice.call(p,
0))}catch(q){for(var r=p.length,t=0;t<r;t++)n.push(p[t])}}else n=h.getElementsByTagName(f);g=!1;f=0;for(c=n.length;f<c;f++)if(DEXT5_EDITOR.HTMLParser.GetChildrenCount(n[f],!0)>v){g=!0;break}if(g)if(h&&h!=a._DOC)try{f=0;c=n.length;for(var u;f<c;f++)DEXT5_EDITOR.HTMLParser.GetChildrenCount(n[f],!0)>v&&(u=b(n[f]),u=DEXT5_EDITOR.HTMLParser.HTMLtoXML(u),n[f].innerHTML=u);return h.innerHTML}catch(w){}else showProcessingBackground(),setTimeout(function(){a._BODY.contentEditable=!1;try{if("2"==d)DEXTTOP.DEXT5.DextCommands("select_all",
a.ID),DEXTTOP.DEXT5.DextCommands("remove_css",a.ID),DEXTTOP.DEXT5.DextCommands("remove_format",a.ID),a._FRAMEWIN.setFocusToBody(),setTimeout(function(){a._FRAMEWIN.doSetCaretPosition(a._BODY.firstChild,0)},20);else for(var c=0,e=n.length,f;c<e;c++)DEXT5_EDITOR.HTMLParser.GetChildrenCount(n[c],!0)>v&&(f=b(n[c]),f=DEXT5_EDITOR.HTMLParser.HTMLtoXML(f),n[c].innerHTML=f)}catch(g){}hideProcessingBackground();a._BODY.contentEditable=!0},G_Progress_LoadTime)};DEXT5_EDITOR.HTMLParser.makeMap=function(a){return q(a)}})();
