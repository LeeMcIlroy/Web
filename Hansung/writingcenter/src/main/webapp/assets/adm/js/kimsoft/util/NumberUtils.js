kimsoft.util.number = {
	toInt : function(n, d) {
		var v = parseInt(n.replace(/,/g, ""), 10);
		if (isNaN(v) && !isNaN(d)) {
			return d;
		} else {
			return v;
		}
	},
	toDouble : function(n, d) {
		var v = parseFloat(n.replace(/,/g, ""), 10);
		if (isNaN(v) && !isNaN(d)) {
			return d;
		} else {
			return v;
		}
	},
	roundPrecision : function(v, p) {
		var po = Math.pow(10, p);
		return Math.round(v * po) / po;
	}
};
