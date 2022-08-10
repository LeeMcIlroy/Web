kimsoft.commonLocalStorage = {
	setLocalData: function (key, val) {
		if(!window.localStorage) {
			setCookie(key, val, 30);
		} else {
			window.localStorage[key] = val;
		}
	},
	removeLocalData: function (key) {
		if(!window.localStorage) {
			setCookie(key, "", 0);
		} else {
			window.localStorage.removeItem(key);
		}
	},
	getLocalData: function (key) {
		var data;
		if(!window.localStorage) {
			data = getCookie(key);
		} else {
			data = window.localStorage[key];
		}
		if (!data) {
			data = "";
		}
		return data;
	}
};
