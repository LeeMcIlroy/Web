kimsoft.util.string = {
	getByteLength : function(input) {
		var byteLength = 0;
		for (var inx = 0; inx < input.value.length; inx++) {
			var oneChar = escape(input.value.charAt(inx));
			if ( oneChar.length == 1 ) {
				byteLength ++;
			} else if (oneChar.indexOf("%u") != -1) {
				byteLength += 2;
			} else if (oneChar.indexOf("%") != -1) {
				byteLength += oneChar.length/3;
			}
		}
		return byteLength;
	},
	cutString : function(input, length, postfix) {
		var byteLength = 0;
		var currLength = 0;
		var result = "";
		for (var inx = 0; inx < input.length; inx++) {
			var oneChar = escape(input.charAt(inx));
			if ( oneChar.length == 1 ) {
				currLength = 1;
			} else if (oneChar.indexOf("%u") != -1) {
				currLength = 2;
			} else if (oneChar.indexOf("%") != -1) {
				currLength = oneChar.length/3;
			} else {
				continue;
			}
			if (byteLength + currLength + postfix.length > length) {
				return result + postfix;
			}
			byteLength += currLength;
			result += input.charAt(inx);
		}
		return input;
	},
	setComma : function(n) {
		n += '';
		var x = n.split('.');
		var x1 = x[0].replace(/,/g, '');
		var x2 = x.length > 1 ? '.' + x[1] : '';
		x1 = x1.replace(/^(0+)(\d+)/, '$2');
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
		    x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
		return x1 + x2;
	},
	str2datepicker : function(d) {
		try {
			if (d.length < 8) {
				return "";
			} else {
				return d.substr(0, 4) + "." + d.substr(4, 2) + "." + d.substr(6, 2);
			}
		} catch(err) {
			return "";
		}
	},
	defaultString : function(s) {
		if (s) {
			return s;
		} else {
			return "";
		}
	},
	fill0 : function(v, n) {
		var tmp = "00000000000000000000" + v;
		return tmp.substr(tmp.length - n);
	},
	date2str : function(d) {
		var year = d.getFullYear();
		var month = d.getMonth() + 1;
		var date = d.getDate();
		return year + "" + fill0("" + month, 2) + fill0("" + date, 2);
	},
	trim : function(v) {
		return v.replace(/^\s+|\s+$/g,"");
	},
	ltrim : function(v) {
		return v.replace(/^\s+/,"");
	},
	rtrim : function(v) {
		return v.replace(/\s+$/,"");
	},
	getCharFromEvent : function(e) {
		var c;
		if (e.charCode == undefined) {
			c = String.fromCharCode(e.which);
		} else {
			c = String.fromCharCode(e.charCode);
		}
		return c;
	}
};
