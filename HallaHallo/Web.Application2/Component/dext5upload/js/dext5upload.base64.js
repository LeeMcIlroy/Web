var Dext5Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",G_CK01:"a",G_CK24:"y",G_CK65:"=",G_AP10:8,G_AP25:"o",G_CK02:"d",G_CK25:"z",G_CK64:"/",_trans_unitDelimiter:"\x0B",G_AP27:"r",G_CK03:"e",G_CK26:"x",G_CK63:"+",_trans_unitAttributeDelimiter:"\f",G_CK04:"b",G_CK27:"A",G_CK62:"9",G_AP23:"n",G_CK05:"c",G_CK28:"H",G_CK61:"5",G_AP12:9,G_CK06:"f",G_CK29:"I",G_CK60:"2",encode:function(a){var b="",c,d,e,g,h,f,k=0;for(a=Dext5Base64._utf8_encode(a);k<a.length;)c=a.charCodeAt(k++),
d=a.charCodeAt(k++),e=a.charCodeAt(k++),g=c>>2,c=(c&3)<<4|d>>4,h=(d&15)<<2|e>>6,f=e&63,isNaN(d)?h=f=64:isNaN(e)&&(f=64),b=b+this._keyStr.charAt(g)+this._keyStr.charAt(c)+this._keyStr.charAt(h)+this._keyStr.charAt(f);return b},G_CK07:"i",G_CK30:"J",G_CK59:"7",G_AP20:"z",G_CK08:"j",G_CK31:"D",G_CK58:"4",decode:function(a){var b="",c,d,e,g,h,f=0;for(a=a.replace(/[^A-Za-z0-9\+\/\=]/g,"");f<a.length;)c=this._keyStr.indexOf(a.charAt(f++)),d=this._keyStr.indexOf(a.charAt(f++)),g=this._keyStr.indexOf(a.charAt(f++)),
h=this._keyStr.indexOf(a.charAt(f++)),c=c<<2|d>>4,d=(d&15)<<4|g>>2,e=(g&3)<<6|h,b+=String.fromCharCode(c),64!=g&&(b+=String.fromCharCode(d)),64!=h&&(b+=String.fromCharCode(e));return b=Dext5Base64._utf8_decode(b)},G_CK09:"g",G_CK32:"B",G_CK57:"8",G_AP:{G_AP29:"w",G_AP22:"a"},G_CK10:"h",G_CK33:"C",G_CK56:"3",_utf8_encode:function(a){a=a.replace(/\r\n/g,"\n");for(var b="",c=0;c<a.length;c++){var d=a.charCodeAt(c);128>d?b+=String.fromCharCode(d):(127<d&&2048>d?b+=String.fromCharCode(d>>6|192):(b+=String.fromCharCode(d>>
12|224),b+=String.fromCharCode(d>>6&63|128)),b+=String.fromCharCode(d&63|128))}return b},G_CK11:"k",G_CK34:"E",G_CK55:"6",G_AP11:6,G_CK12:"l",G_CK35:"F",G_CK54:"1",G_AP24:"i",G_CK13:"o",G_CK36:"L",G_CK53:"0",_utf8_decode:function(a){for(var b="",c=0,d=c1=c2=0;c<a.length;)d=a.charCodeAt(c),128>d?(b+=String.fromCharCode(d),c++):191<d&&224>d?(c2=a.charCodeAt(c+1),b+=String.fromCharCode((d&31)<<6|c2&63),c+=2):(c2=a.charCodeAt(c+1),c3=a.charCodeAt(c+2),b+=String.fromCharCode((d&15)<<12|(c2&63)<<6|c3&63),
c+=3);return b},G_CK14:"p",G_CK37:"M",G_CK52:"Z",G_AP13:7,G_CK15:"m",G_CK38:"N",G_CK51:"Y",makeEncryptParam:function(a){a=Dext5Base64.encode(a);a="R"+a;a=Dext5Base64.encode(a);return a=a.replace(/[+]/g,"%2B")},G_CK16:"n",G_CK39:"U",G_CK50:"Q",makeEncryptParamEx:function(a){a=Dext5Base64.encode(a);10<=a.length?(a=Dext5Base64.insertAt(a,Dext5Base64.G_AP10,Dext5Base64.G_AP27),a=Dext5Base64.insertAt(a,Dext5Base64.G_AP11,Dext5Base64.G_AP.G_AP22),a=Dext5Base64.insertAt(a,Dext5Base64.G_AP12,Dext5Base64.G_AP25),
a=Dext5Base64.insertAt(a,Dext5Base64.G_AP13,Dext5Base64.G_AP23),a=Dext5Base64.insertAt(a,Dext5Base64.G_AP10,Dext5Base64.G_AP.G_AP29),a=Dext5Base64.insertAt(a,Dext5Base64.G_AP11,Dext5Base64.G_AP24),a=Dext5Base64.insertAt(a,Dext5Base64.G_AP12,Dext5Base64.G_AP20)):(a=Dext5Base64.insertAt(a,a.length-1,"$"),a=Dext5Base64.insertAt(a,0,"$"));return a=a.replace(/[+]/g,"%2B")},G_CK17:"q",G_CK40:"V",G_CK49:"P",makeEncryptParamEx2:function(a){a=Dext5Base64.cipher_encode(a);return a=a.replace(/[+]/g,"%2B")},
G_CK18:"r",G_CK41:"G",makeEncryptParamEx3:function(a){var b=Dext5Base64.G_CK01+Dext5Base64.G_CK02+Dext5Base64.G_CK03+Dext5Base64.G_CK04+Dext5Base64.G_CK05+Dext5Base64.G_CK06+Dext5Base64.G_CK07+Dext5Base64.G_CK08+Dext5Base64.G_CK09+Dext5Base64.G_CK10+Dext5Base64.G_CK11+Dext5Base64.G_CK12+Dext5Base64.G_CK13+Dext5Base64.G_CK14+Dext5Base64.G_CK15+Dext5Base64.G_CK16+Dext5Base64.G_CK17+Dext5Base64.G_CK18+Dext5Base64.G_CK19+Dext5Base64.G_CK20+Dext5Base64.G_CK21+Dext5Base64.G_CK22+Dext5Base64.G_CK23+Dext5Base64.G_CK24+
Dext5Base64.G_CK25+Dext5Base64.G_CK26+Dext5Base64.G_CK27+Dext5Base64.G_CK28+Dext5Base64.G_CK29+Dext5Base64.G_CK30+Dext5Base64.G_CK31+Dext5Base64.G_CK32+Dext5Base64.G_CK33+Dext5Base64.G_CK34+Dext5Base64.G_CK35+Dext5Base64.G_CK36+Dext5Base64.G_CK37+Dext5Base64.G_CK38+Dext5Base64.G_CK39+Dext5Base64.G_CK40+Dext5Base64.G_CK41+Dext5Base64.G_CK42+Dext5Base64.G_CK43+Dext5Base64.G_CK44+Dext5Base64.G_CK45+Dext5Base64.G_CK46+Dext5Base64.G_CK47+Dext5Base64.G_CK48+Dext5Base64.G_CK49+Dext5Base64.G_CK50+Dext5Base64.G_CK51+
Dext5Base64.G_CK52+Dext5Base64.G_CK53+Dext5Base64.G_CK54+Dext5Base64.G_CK55+Dext5Base64.G_CK56+Dext5Base64.G_CK57+Dext5Base64.G_CK58+Dext5Base64.G_CK59+Dext5Base64.G_CK60+Dext5Base64.G_CK61+Dext5Base64.G_CK62+Dext5Base64.G_CK63+Dext5Base64.G_CK64+Dext5Base64.G_CK65,c=a;a=Dext5Base64.makeGuid().toLowerCase();a=Dext5Base64.encode(a);a=a.substring(0,15);var d=CryptoJS.enc.Utf8.parse(a);d.sigBytes=16;c=CryptoJS.enc.Utf8.parse(c);c=CryptoJS.AES.encrypt(c,d,{iv:d});d=CryptoJS.enc.Base64._map;CryptoJS.enc.Base64._map=
b;c=a+CryptoJS.enc.Base64.stringify(c.ciphertext);CryptoJS.enc.Base64._map=d;return c=c.replace(/[+]/g,"%2B")},G_CK48:"X",insertAt:function(a,b,c){return String.prototype.insertAt?a.insertAt(b,c):a.substr(0,b)+c+a.substr(b)},G_CK19:"u",G_CK42:"K",G_CK47:"W",makeDecryptReponseMessage:function(a){a=Dext5Base64.decode(a);a=a.substring(1);return a=Dext5Base64.decode(a)},G_CK20:"v",G_CK46:"O",makeDecryptReponseMessageEx:function(a){var b=function(a,b){var e=a.split("");e.splice(b,1);return e=e.join("")};
a=a.replace(/ /g,"");a=a.replace(/\r/g,"");a=a.replace(/\n/g,"");a=a.replace(/%2B/g,"+");15<=a.length?(a=b(a,9),a=b(a,6),a=b(a,8),a=b(a,7),a=b(a,9),a=b(a,6),a=b(a,8)):(a=a.replace(/#/g,""),a=a.replace(/$/g,""));return a=Dext5Base64.decode(a)},makeDecryptReponseMessageEx2:function(a){var b=Dext5Base64.G_CK01+Dext5Base64.G_CK02+Dext5Base64.G_CK03+Dext5Base64.G_CK04+Dext5Base64.G_CK05+Dext5Base64.G_CK06+Dext5Base64.G_CK07+Dext5Base64.G_CK08+Dext5Base64.G_CK09+Dext5Base64.G_CK10+Dext5Base64.G_CK11+Dext5Base64.G_CK12+
Dext5Base64.G_CK13+Dext5Base64.G_CK14+Dext5Base64.G_CK15+Dext5Base64.G_CK16+Dext5Base64.G_CK17+Dext5Base64.G_CK18+Dext5Base64.G_CK19+Dext5Base64.G_CK20+Dext5Base64.G_CK21+Dext5Base64.G_CK22+Dext5Base64.G_CK23+Dext5Base64.G_CK24+Dext5Base64.G_CK25+Dext5Base64.G_CK26+Dext5Base64.G_CK27+Dext5Base64.G_CK28+Dext5Base64.G_CK29+Dext5Base64.G_CK30+Dext5Base64.G_CK31+Dext5Base64.G_CK32+Dext5Base64.G_CK33+Dext5Base64.G_CK34+Dext5Base64.G_CK35+Dext5Base64.G_CK36+Dext5Base64.G_CK37+Dext5Base64.G_CK38+Dext5Base64.G_CK39+
Dext5Base64.G_CK40+Dext5Base64.G_CK41+Dext5Base64.G_CK42+Dext5Base64.G_CK43+Dext5Base64.G_CK44+Dext5Base64.G_CK45+Dext5Base64.G_CK46+Dext5Base64.G_CK47+Dext5Base64.G_CK48+Dext5Base64.G_CK49+Dext5Base64.G_CK50+Dext5Base64.G_CK51+Dext5Base64.G_CK52+Dext5Base64.G_CK53+Dext5Base64.G_CK54+Dext5Base64.G_CK55+Dext5Base64.G_CK56+Dext5Base64.G_CK57+Dext5Base64.G_CK58+Dext5Base64.G_CK59+Dext5Base64.G_CK60+Dext5Base64.G_CK61+Dext5Base64.G_CK62+Dext5Base64.G_CK63+Dext5Base64.G_CK64+Dext5Base64.G_CK65,c={result:"",
value:""},d=a.toLowerCase();if(-1<d.indexOf("<dext5>"))try{a=a.substring(d.indexOf("<dext5>")+7,d.lastIndexOf("</dext5>"));a=a.replace(/ /g,"");a=a.replace(/\r/g,"");a=a.replace(/\n/g,"");a=a.replace(/%2B/g,"+");var e=a.substring(0,14);a=a.substring(14);e=CryptoJS.enc.Utf8.parse(e);e.sigBytes=16;var g=CryptoJS.enc.Base64._map;CryptoJS.enc.Base64._map=b;a=CryptoJS.enc.Base64.parse(a);CryptoJS.enc.Base64._map=g;a=CryptoJS.AES.decrypt({ciphertext:a},e,{iv:e}).toString(CryptoJS.enc.Utf8);c.result="success";
c.value=a}catch(h){c.result="error",c.value="error|029|response data decrypt error"}else c.result="fail",c.value="";return c},G_CK21:"s",makeGuid:function(a){var b=function(){return(65536*(1+Math.random())|0).toString(16).substring(1)},b=(b()+b()+"-"+b()+"-"+b()+"-"+b()+"-"+b()+b()+b()).toUpperCase();void 0!=a&&(b=a+"-"+b);return b},G_CK45:"T",cipher_decode:function(a){var b=Dext5Base64.G_CK01+Dext5Base64.G_CK02+Dext5Base64.G_CK03+Dext5Base64.G_CK04+Dext5Base64.G_CK05+Dext5Base64.G_CK06+Dext5Base64.G_CK07+
Dext5Base64.G_CK08+Dext5Base64.G_CK09+Dext5Base64.G_CK10+Dext5Base64.G_CK11+Dext5Base64.G_CK12+Dext5Base64.G_CK13+Dext5Base64.G_CK14+Dext5Base64.G_CK15+Dext5Base64.G_CK16+Dext5Base64.G_CK17+Dext5Base64.G_CK18+Dext5Base64.G_CK19+Dext5Base64.G_CK20+Dext5Base64.G_CK21+Dext5Base64.G_CK22+Dext5Base64.G_CK23+Dext5Base64.G_CK24+Dext5Base64.G_CK25+Dext5Base64.G_CK26+Dext5Base64.G_CK27+Dext5Base64.G_CK28+Dext5Base64.G_CK29+Dext5Base64.G_CK30+Dext5Base64.G_CK31+Dext5Base64.G_CK32+Dext5Base64.G_CK33+Dext5Base64.G_CK34+
Dext5Base64.G_CK35+Dext5Base64.G_CK36+Dext5Base64.G_CK37+Dext5Base64.G_CK38+Dext5Base64.G_CK39+Dext5Base64.G_CK40+Dext5Base64.G_CK41+Dext5Base64.G_CK42+Dext5Base64.G_CK43+Dext5Base64.G_CK44+Dext5Base64.G_CK45+Dext5Base64.G_CK46+Dext5Base64.G_CK47+Dext5Base64.G_CK48+Dext5Base64.G_CK49+Dext5Base64.G_CK50+Dext5Base64.G_CK51+Dext5Base64.G_CK52+Dext5Base64.G_CK53+Dext5Base64.G_CK54+Dext5Base64.G_CK55+Dext5Base64.G_CK56+Dext5Base64.G_CK57+Dext5Base64.G_CK58+Dext5Base64.G_CK59+Dext5Base64.G_CK60+Dext5Base64.G_CK61+
Dext5Base64.G_CK62+Dext5Base64.G_CK63+Dext5Base64.G_CK64+Dext5Base64.G_CK65,c="",d,e,g,h,f,k=0;for(a=a.replace(/[^A-Za-z0-9\+\/\=]/g,"");k<a.length;)d=b.indexOf(a.charAt(k++)),e=b.indexOf(a.charAt(k++)),h=b.indexOf(a.charAt(k++)),f=b.indexOf(a.charAt(k++)),d=d<<2|e>>4,e=(e&15)<<4|h>>2,g=(h&3)<<6|f,c+=String.fromCharCode(d),64!=h&&(c+=String.fromCharCode(e)),64!=f&&(c+=String.fromCharCode(g));return c=Dext5Base64._utf8_decode(c)},G_CK22:"t",G_CK44:"S",cipher_encode:function(a){var b=Dext5Base64.G_CK01+
Dext5Base64.G_CK02+Dext5Base64.G_CK03+Dext5Base64.G_CK04+Dext5Base64.G_CK05+Dext5Base64.G_CK06+Dext5Base64.G_CK07+Dext5Base64.G_CK08+Dext5Base64.G_CK09+Dext5Base64.G_CK10+Dext5Base64.G_CK11+Dext5Base64.G_CK12+Dext5Base64.G_CK13+Dext5Base64.G_CK14+Dext5Base64.G_CK15+Dext5Base64.G_CK16+Dext5Base64.G_CK17+Dext5Base64.G_CK18+Dext5Base64.G_CK19+Dext5Base64.G_CK20+Dext5Base64.G_CK21+Dext5Base64.G_CK22+Dext5Base64.G_CK23+Dext5Base64.G_CK24+Dext5Base64.G_CK25+Dext5Base64.G_CK26+Dext5Base64.G_CK27+Dext5Base64.G_CK28+
Dext5Base64.G_CK29+Dext5Base64.G_CK30+Dext5Base64.G_CK31+Dext5Base64.G_CK32+Dext5Base64.G_CK33+Dext5Base64.G_CK34+Dext5Base64.G_CK35+Dext5Base64.G_CK36+Dext5Base64.G_CK37+Dext5Base64.G_CK38+Dext5Base64.G_CK39+Dext5Base64.G_CK40+Dext5Base64.G_CK41+Dext5Base64.G_CK42+Dext5Base64.G_CK43+Dext5Base64.G_CK44+Dext5Base64.G_CK45+Dext5Base64.G_CK46+Dext5Base64.G_CK47+Dext5Base64.G_CK48+Dext5Base64.G_CK49+Dext5Base64.G_CK50+Dext5Base64.G_CK51+Dext5Base64.G_CK52+Dext5Base64.G_CK53+Dext5Base64.G_CK54+Dext5Base64.G_CK55+
Dext5Base64.G_CK56+Dext5Base64.G_CK57+Dext5Base64.G_CK58+Dext5Base64.G_CK59+Dext5Base64.G_CK60+Dext5Base64.G_CK61+Dext5Base64.G_CK62+Dext5Base64.G_CK63+Dext5Base64.G_CK64+Dext5Base64.G_CK65,c="",d,e,g,h,f,k,l=0;for(a=Dext5Base64._utf8_encode(a);l<a.length;)d=a.charCodeAt(l++),e=a.charCodeAt(l++),g=a.charCodeAt(l++),h=d>>2,d=(d&3)<<4|e>>4,f=(e&15)<<2|g>>6,k=g&63,isNaN(e)?f=k=64:isNaN(g)&&(k=64),c=c+b.charAt(h)+b.charAt(d)+b.charAt(f)+b.charAt(k);return c},G_CK23:"w",G_CK43:"R",makeEncryptParamFinal:function(a,
b){var c={name:"",value:""};"1"==a?(c.name="d00",c.value=Dext5Base64.makeEncryptParam(b)):"2"==a?(c.name="d01",c.value=Dext5Base64.makeEncryptParamEx(b)):"3"==a?(c.name="d02",c.value=Dext5Base64.makeEncryptParamEx2(b)):"4"==a&&(c.name="d03",c.value=Dext5Base64.makeEncryptParamEx3(b));return c}};