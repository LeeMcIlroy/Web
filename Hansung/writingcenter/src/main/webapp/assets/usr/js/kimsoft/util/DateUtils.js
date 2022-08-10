kimsoft.util.date = {
	dayOfWeek1 : {
				Mon: "월",
				Tue: "화",
				Wed: "수",
				Thu: "목",
				Fri: "금",
				Sat: "토",
				Sun: "일",
				0: "일요일",
				1: "월요일",
				2: "화요일",
				3: "수요일",
				4: "목요일",
				5: "금요일",
				6: "토요일"
	},
	calcAge : function(date1, date2) {
		var year1 = kimsoft.util.number.toInt(date1.substring(0, 4), 0);
		var year2 = kimsoft.util.number.toInt(date2.substring(0, 4), 0);
		if (year1 == 0 || year2 == 0) {
			return -10;
		}
		var age = year2 - year1;
		if (date1.substring(4, 8) > date2.substring(4, 8)) {
			--age;
		}
		return age;
	},
	date2dayOfWeek : function(date) {
		return this.dayOfWeek1[date.getDay()];
	}
};
