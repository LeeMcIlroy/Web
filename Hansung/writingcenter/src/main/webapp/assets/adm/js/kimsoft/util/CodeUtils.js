kimsoft.util.code = {
	getCodeValue : function(infos, code) {
		for(var i=0; i<infos.length; ++i) {
			var info = infos[i];
			if (info.code == code) {
				return info.value;
			}
		}
		return "";
	},
	getCodeByValue : function(infos, value, codeCol, valueCol) {
		for(var i=0; i<infos.length; ++i) {
			var info = infos[i];
			if (info[valueCol] == value) {
				return info[codeCol];
			}
		}
		return "";
	},
	updateCodeValue : function(infos, codeInfos, codeCol, valueCol) {
		for(var i=0; i<infos.length; ++i) {
			var info = infos[i];

			info[valueCol] = this.getCodeValue(codeInfos, info[codeCol]);
		}
	}
};
