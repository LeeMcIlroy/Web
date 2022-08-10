kimsoft.util.file = {
	getFileName : function(path) {
		if (path.lastIndexOf("\\") >= 0) {
			return path.substring(path.lastIndexOf("\\") + 1);
		} else if (path.lastIndexOf("/") >= 0) {
			return path.substring(path.lastIndexOf("/") + 1);
		} else {
			return path;
		}
	},
	getFileExt : function(path) {
		if (path.lastIndexOf(".") >= 0) {
			return path.substring(path.lastIndexOf(".") + 1);
		} else {
			return "";
		}
	}
};
