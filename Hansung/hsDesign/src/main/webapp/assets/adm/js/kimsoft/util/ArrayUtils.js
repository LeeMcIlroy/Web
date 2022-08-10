kimsoft.util.array = {
	calcIndex : function(obj, order) {
		var arrObj = kimsoft.util.array.obj2Array(obj);
		for (var idx = 0; idx < arrObj.length; idx++) {
			if (order == "DESC") {
				arrObj[idx].index = arrObj.length - idx;
			} else {
				arrObj[idx].index = idx + 1;
			}
		}
	},
	obj2Array : function(data) {
		if (data == null) {
			return [];
		} else if ($.isArray(data)) {
			return data;
		} else if (data.length != undefined) {
			var result = [];
			for(var i=0; i<data.length; ++i) {
				result[i] = data[i];
			}
			return result;
		} else {
			return [data];
		}
	}
};
