///////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ** 입력 폼 validate 체크, 입력 폼 초기화, 자료 포메팅 처리
// 
// 작 성 자 : 박창모 (pronema@hanmail.net)
// 최초 작성일 : 2003년 01월 09일
// 버전 : 3.0 (2008년 02월 22일 기준)
//
///////////////////////////////////////////////////////////////////////////////////////////////////////

	// disable 속성 세팅
	 
	function setDisabled(fields, flag)
	{
		if(typeof(fields) != 'undefined')
		{
			if(fields.length && fields[0].type)
			{
				for(i=0; i<fields.length; i++)
					fields[i].disabled = flag;
			}
			else
				fields.disabled = flag;
		}
	}


	function setCalDate(targetName, returnStr)
	{
		eval(targetName).value = returnStr;
	}

	// 택스트 필드 세팅

	function setTextForm(textForm, value)
	{
		if(textForm)
			textForm.value = value;
		else
			alert("해당필드가 존재하지 않습니다.");
	}

	// 셀랙트 박스 세팅

	function setSelectForm(selectForm, value)
	{
		if(selectForm)
		{
			if(selectForm.length)
			{
				for(i=0; i<selectForm.length; i++)
				{
					if(selectForm[i].value == value)
						selectForm[i].selected = true;
					else
						selectForm[i].selected = false;
				}
			}
			else
			{
				if(selectForm.value = value)
					selectForm.selected = true;
				else
					selectForm.selected = false;
			}
		}
		else
			alert("해당필드가 존재하지 않습니다.");
	}

	// 라디오 박스 세팅

	function setRadioForm(radioForm, value)
	{
		if(radioForm)
		{
			if(radioForm.length)
			{
				for(i=0; i<radioForm.length; i++)
				{
					if(radioForm[i].value == value)
						radioForm[i].checked = true;
					else
						radioForm[i].checked = false;
				}
			}
			else
			{
				if(radioForm.value = value)
					radioForm.checked = true;
				else
					radioForm.checked = false;
			}
		}
		else
			alert("해당필드가 존재하지 않습니다.");
	}

	// 체크 박스 세팅

	function setCheckForm(checkForm, value)
	{
		if(checkForm)
		{
			if(checkForm.length)
			{
				for(i=0; i<checkForm.length; i++)
				{
					if(checkForm[i].value == value)
						checkForm[i].checked = true;
					else
						checkForm[i].checked = false;
				}
			}
			else
			{
				if(checkForm.value == value)
					checkForm.checked = true;
				else
					checkForm.checked = false;
			}
		}
		else
			alert("해당필드가 존재하지 않습니다. 어떻게 된겨?");
	}

	// 해당필드의 null 체크

	function isNullfields(fields)
	{
		var result = true;

		if(fields.length)
		{
			for(i=0; i<fields.length; i++)
			{
				if(fields[i].value == '')
				{
					result = false;
					break;
				}
			}
		}
		else
		{
			if(fields.value == '')
				result = false;
		}

		return result;
	}


	// 체크 박스 선택 유무 검사

	function inspectCheckBox(formNames, fieldNames)
	{
		fields = eval('document.' + formNames + '.' + fieldNames);

		var result = inspectCheckBoxField(fields);

		return result;
	}

	// 체크 박스 선택 유무 검사

	function inspectCheckBoxField(checkForm)
	{
		var result = false;

		if(typeof(checkForm) != 'undefined')
		{
			if(checkForm.length)
			{
				for(i=0; i<checkForm.length; i++)
				{
					if(checkForm[i].checked == true)
					{
						result = true;
						break;
					}
				}
			}
			else
			{
				if(checkForm.checked == true)
					result = true;
			}
		}

		return result;
	}


	// 체크박스 전체 선택/해제

	function checkBoxToggle(formNames, fieldNames)
	{
		var fields = eval('document.' + formNames + '.' + fieldNames);

		checkBoxFieldToggle(fields);
	}

	// 체크박스 체크 토글 처리

	function checkBoxFieldToggle(fields)
	{
		var check = false;

		if(fields)
		{
			if(fields.length)
			{
				for(i=0; i<fields.length; i++)
				{
					if(fields[i].checked == false)
					{
						check = true;
						break;
					}
				}

				for(i=0; i<fields.length; i++)
				{
					if(fields[i].disabled == false)
						fields[i].checked = check;
				}
			}
			else
			{
				if(fields.checked == false)
					check = true;

				if(fields.disabled == false)
					fields.checked = check;
			}
		}
	}

	// 선택 안된 체크 박스값 부여해서 넘겨주기

	function setCheckBoxByValue(fields, values)
	{
		if(typeof(fields) != 'undefined')
		{
			if(fields.length)
			{
				for(var i=0; i<fields.length; i++)
				{
					if(fields[i].checked != true)
					{
						fields[i].value   = values;
						fields[i].checked = 'true'; 
					}				
				}
			}
			else
			{
				if(fields.checked != true)
				{
					fields.value   = values;
					fields.checked = 'true'; 
				}				
			}
		}
	}

	// 체크박스를 라디오박스처럼 체크 (위치에 의한 체크)

	function checkBoxSameRadioBox(fields, pos)
	{
		checkBoxToggleByKey(fields, false);

		if(fields)
		{
			if(fields.length)
				fields[pos].checked = true;
			else
				fields.checked = true;
		}
	}

	// 체크박스 전체 선택/해제

	function checkBoxToggleByKey(fields, key)
	{
		if(fields)
		{
			if(fields.length)
			{
				for(i=0; i<fields.length; i++)
					fields[i].checked = key;
			}
			else
				fields.checked = key;
		}
	}

	// 체크박스 선택된 항목 다른 체크박스에 복사

	function checkBoxCopy(sFields, tFields)
	{
		if(sFields)
		{
			if(sFields.length)
			{
				if(sFields.length == tFields.length)
				{
					for(i=0; i<sFields.length; i++)
					{
						if(sFields[i].checked == true)
							tFields[i].checked = true;
						else
							tFields[i].checked = false;
					}
				}
			}
			else
			{
				if(sFields.checked == true)
					tFields.checked = true;
				else
					tFields.checked = false;
			}
		}
	}

	// 보여지는 레이어내 존재하는 체크박스 전체 선택/해제

	function layerCheckBoxToggle(layerNames, formNames, fieldNames)
	{
		layer = eval('document.all.' + layerNames);

		var maxIndex = layer.length;
		var lastShowIndex = 0;
		var check = false;

		for(i=0; i<maxIndex; i++)
		{
			lastShowIndex = i;

			if(layer[i].style.display == 'none')
				break;
			else if(i == maxIndex-1)
				lastShowIndex++;
		}

		fields = eval('document.' + formNames + '.' + fieldNames);

		if(fields)
		{
			if(fields.length)
			{
				for(i=0; i<lastShowIndex; i++)
				{
					if(fields[i].checked == false)
					{
						check = true;
						break;
					}
				}

				for(i=0; i<lastShowIndex; i++)
					fields[i].checked = check;

				for(i=lastShowIndex; i<fields.length; i++)
					fields[i].checked = false;
			}
			else
			{
				if(fields.checked == false)
					check = true;

				fields.checked = check;
			}
		}
	}

	// 보여지는 레이어내 존재하는 체크박스 전체 선택/해제

	function layerCheckBoxToggle2(layerNames, formNames, fieldNames,checkYn)
	{
		layer = eval('document.all.' + layerNames);

		var maxIndex = layer.length;
		var lastShowIndex = 0;
		var check = false;
		check = checkYn;

		for(i=0; i<maxIndex; i++)
		{
			lastShowIndex = i;


			if(layer[i].style.display == 'none')
			{
				break;
			}
			else if(i == maxIndex-1)
			{
				lastShowIndex++;
			}
		}

		if(lastShowIndex == 0)
		{
			fields = eval('document.' + formNames + '.' + layerNames  + "." + fieldNames);
			fields[0].checked = checkYn;
		}
		else
		{

			fields = eval('document.all.' + layerNames + "." + fieldNames);
			if(fields)
			{

				if(fields.length)
				{

					for(i=0; i<lastShowIndex; i++)
						fields[i].checked = check;

					for(i=lastShowIndex; i<fields.length; i++)
						fields[i].checked = false;

				}
			}
		}
	}

	function layerCheckBoxToggle3(layerNames, formNames, fieldNames,checkYn,num)
	{
		layer = eval('document.all.' + layerNames);

		var maxIndex = layer.length;
		var lastShowIndex = 0;
		var check = false;
		check = checkYn;

		for(i=0; i<maxIndex; i++)
		{
			lastShowIndex = i;


			if(layer[i].style.display == 'none')
			{
				break;
			}
			else if(i == maxIndex-1)
			{
				lastShowIndex++;
			}
		}

		//alert(lastShowIndex);
		if(lastShowIndex == 0)
		{
			fields = eval('document.' + formNames  + "." + fieldNames);
			fields[num - 1].checked = checkYn;
		}
		else
		{

			fields = eval('document.all.' + layerNames + "." + fieldNames);
			if(fields)
			{

				if(fields.length)
				{

					for(i=0; i<lastShowIndex; i++)
						fields[i].checked = check;

					for(i=lastShowIndex; i<fields.length; i++)
						fields[i].checked = false;

				}
			}
		}
	}

	// 셀렉트 박스에 옵션 추가

	function addOptions(formName, fieldName, value)
	{
		fields = eval("document." + formName + "." + fieldName);

		var lastPos = fields.length + 1;

		fields.length = lastPos;

		fields[lastPos-1].text = value;
		fields[lastPos-1].value = value;

		fields[lastPos-1].selected = true;
	}

	// 선택된 라디오 버튼 값 구하기

	function getRadioValue(fields)
	{
		var result = '';

		if(fields.length)
		{
			for(i=0; i<fields.length; i++)
			{
				if(fields[i].checked == true)
				{
					result = fields[i].value;
					break;
				}
			}
		}

		return result;
	}
	
	//선택된 라디오 버튼값을 구한다.(숫자 계산시 )
	function getRadioValueCheck(fields)
	{

		var result = 0;
		var value = new Number(getRadioValue(fields));
		if(value == '' || value == 'undefined')
		{
			result = 0;
		}else{
			result = value;
		}
		return result;
	}

///////////////////////////////////////////////////////////////////////////////////////////////////////
	// 3. 포멧 관련 펑션

	// 숫자만 입력받고 Space Bar를 누르면 지움

	function checkNumberKey()
	{
		if (event.keyCode != 8)
		{
			if(event.keyCode < 45 || event.keyCode > 57 || ((event.keyCode > 32 && event.keyCode < 46) || event.keyCode == 47 || (event.keyCode > 57 && event.keyCode < 65) || (event.keyCode > 90 && event.keyCode < 97)))
		    	event.returnValue = false;
		}
	}

	function checkNumberField(fields)
	{
		checkNumberFields(fields, 0);
	}

	function checkNumberFields(fields, size)
	{
		size = new Number(size);
	
		checkNumberKey();

	    if(event.keyCode == 27 || event.keyCode == 32)
	    	fields.value = 0;
	    else 
	    {	

	    	var values = fields.value;

			var splitArr = values.split('.');

			if(size == 0 && event.keyCode == 46)
			{
	    		alert('소숫점 자리수를 입력할 수 없습니다.');
	    		event.returnValue = false;
			}	
			else if(size > 0)
			{
				if(event.keyCode != 46)
				{
		    		if(values.indexOf('.') > 0 && (values.length - values.indexOf('.')) > size)
		    		{
			    		alert('소숫점 자리수가 ' + size + '자리를 넘을 수 없습니다.');
			    		event.returnValue = false;
			    	}	
			    }	
				else if(values.indexOf('.') > 0 && event.keyCode == 46)
	    		{
		    		alert('소숫점은 하나만 입력할 수 있습니다.');
		    		event.returnValue = false;
		    	}	
			}
	    }	
	}

	// 돈계산 포멧으로 변환 (입력 포멧)

	function moneyFormats(fields)
	{
	    var num = (new String(fields.value)).replace(/,/gi,"");

	    fields.value = moneyFormatChange(num);
	}

	function moneyFormatChange(num)
	{
	    var sign="";

	    if(isNaN(num))
	    {
			alert("숫자만 입력할 수 있습니다.");
			return 0;
		}

	    if(num == 0)
		 	return num;

	    if(num < 0)
	    {
	        num= num*(-1);
	        sign = "-";
	    }
	    else
	        num = num*1;

	    var temp = "";
	    var pos = 3;

	    var source		= new String(num);
		var numStr		= '';
	    var remainStr	= '';

		if(source.indexOf(".") > 0)
		{
			numStr		= source.substring(0, source.indexOf("."));
			remainStr	= source.substring(source.indexOf("."));
		}
		else
		{
			numStr		= source;

			if(event.keyCode == 190)
				remainStr = '.';
		}	

	    var num_len = new String(numStr).length;

	    while(num_len > 0)
	    {
	        num_len = num_len - pos;

	        if(num_len < 0)
	        {
				pos = num_len + pos;
				num_len = 0;
			}

	        temp = ","+ numStr.substr(num_len, pos) + temp;
	    }

	    return sign + temp.substr(1) + remainStr;
	}


	// 돈포멧을 숫자형으로

	function numberFormats(fields)
	{
		if(fields.length)
		{
			for(z=0; z<fields.length; z++)
			{
				if(fields[z].value != 0 && fields[z].value != '')
					fields[z].value = numberFormat(fields[z].value);
			}
		}
		else
			fields.value = numberFormat(fields.value);

	}

	function numberFormat(data)
	{
		var num = '';

		if(data != '')
		    num = (new String(data)).replace(/,/gi,"");
		else
			num = '0';

	    return num;
	}

	// 주민번호 체크

	function sNumberCheck1(str_jumin1, str_jumin2)
	{
		var result = false;

		var i3 = 0

		for (var i=0;i<str_jumin1.length;i++)
		{
			var ch1 = str_jumin1.substring(i, i+1);

			if (ch1<'0' || ch1>'9')
				i3 = i3 + 1;
		}

		if(str_jumin1 != '' && i3 == 0)
		{
			var i4 = 0;

			for (var i=0;i<str_jumin2.length;i++)
			{
				var ch1 = str_jumin2.substring(i, i+1);

				if(ch1<'0' || ch1>'9')
					i4 = i4 + 1;
			}

			if(str_jumin2 != '' && i4 == 0 && str_jumin1.substring(0,1) >= 4 && str_jumin2.substring(0,1) <= 2 && str_jumin1.length <= 7 && str_jumin2.length <= 8 && str_jumin1 != '72' && str_jumin2 != '18')
			{
				var f1=str_jumin1.substring(0,1)
				var f2=str_jumin1.substring(1,2)
				var f3=str_jumin1.substring(2,3)
				var f4=str_jumin1.substring(3,4)
				var f5=str_jumin1.substring(4,5)
				var f6=str_jumin1.substring(5,6)

				var l1=str_jumin2.substring(0,1)
				var l2=str_jumin2.substring(1,2)
				var l3=str_jumin2.substring(2,3)
				var l4=str_jumin2.substring(3,4)
				var l5=str_jumin2.substring(4,5)
				var l6=str_jumin2.substring(5,6)
				var l7=str_jumin2.substring(6,7)

				var hap = (11 - (f1*2+f2*3+f3*4+f4*5+f5*6+f6*7 + l1*8+l2*9+l3*2+l4*3+l5*4+l6*5)%11)%10;

				if (hap == l7)

				result = true;
			}
		}

		return result;
	}

	function sNumberCheck(str_jumin1, str_jumin2)
	{
		if (str_jumin1.length != 6)
			return false;
		else if (str_jumin2.length != 7)
			return false;
		else
		{
			var str_first_re = str_jumin1;
			var str_last_re = str_jumin2;
			var digit=0

			for (var i=0;i<str_first_re.length;i++)
			{
				var str_dig=str_first_re.substring(i,i+1);

				if (str_dig<'0' || str_dig>'9')
					digit=digit+1 
			}
		}
		
		if ((str_first_re == '') || ( digit != 0 ))
			return false;   
	
		var digit1=0
	
		for (var i=0;i<str_last_re.length;i++)
		{
			var str_dig1=str_last_re.substring(i,i+1);
	
			if (str_dig1<'0' || str_dig1>'9')
				digit1=digit1+1 
		}
	
		if ((str_last_re == '') || ( digit1 != 0 ))
			return false;   
		
		if (str_first_re.substring(2,3) > 1)
			return false;   
		
		if (str_first_re.substring(4,5) > 3)
			return false;   
		
		if (str_last_re.substring(0,1) > 4 || str_last_re.substring(0,1) == 0)
			return false;   
		
		var a1=str_first_re.substring(0,1)
		var a2=str_first_re.substring(1,2)
		var a3=str_first_re.substring(2,3)
		var a4=str_first_re.substring(3,4)
		var a5=str_first_re.substring(4,5)
		var a6=str_first_re.substring(5,6)
		var check_digit=a1*2+a2*3+a3*4+a4*5+a5*6+a6*7
		var b1=str_last_re.substring(0,1)
		var b2=str_last_re.substring(1,2)
		var b3=str_last_re.substring(2,3)
		var b4=str_last_re.substring(3,4)
		var b5=str_last_re.substring(4,5)
		var b6=str_last_re.substring(5,6)
		var b7=str_last_re.substring(6,7)
		var check_digit=check_digit+b1*8+b2*9+b3*2+b4*3+b5*4+b6*5 
		check_digit = check_digit%11
		check_digit = 11 - check_digit
		check_digit = check_digit%10
	
		if (check_digit != b7)
			return false;   
		
		return true;
	}


	function checkFilesKind(fields, fileKind)
	{
		var result = false;
		
		if(typeof(fields) != 'undefined')
		{
			if(fields.length)
			{
				for(i=0; i<fields.length; i++)
				{
					result = checkFileKind(fields[i].value, fileKind);
				
					if(result == false)
					{
						break;
					}
				}
			}
			else
				result = checkFileKind(fields.value, fileKind);
		}
		
		return result;
	
	}


	// 첨부파일 종류 체크

	function checkFileKind(filePath, fileKind)
	{
		var result = false;

		if(filePath != '' && fileKind != '')
		{
			var fileName = filePath.substr(filePath.lastIndexOf("\\")+1);
			var extName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();

			if(fileKind == 'image')
			{
				if(extName == 'JPG' || extName == 'GIF' || extName == 'BMP')
					result = true;
			}

			if(fileKind == 'jsp')
			{
				if(extName == 'JSP')
					result = true;
			}

			if(fileKind == 'xml')
			{
				if(extName == 'XML')
					result = true;
			}

			if(fileKind == 'pa')
			{
				if(extName == 'CLASS')
					result = true;
			}

			if(fileKind == 'swf')
			{
				if(extName == 'SWF')
					result = true;
			}
			
			if(fileKind == 'doc')
			{
				if(extName == 'DOC' || extName == 'HWP' || extName == 'PPT' || extName == 'XLS' || extName == 'TXT')
					result = true;
			}
		}
		else
			result = true;

		return result;
	}

	// 현재날짜 리턴 (예) 20050404)
	
	function getCurrentDate()
	{
        d=new Date();
        //yy=d.getYear();			// 2000년도 이상일때 잘못된 값이 리턴됨 ex)2013년일때 113이 리턴
        yy = d.getFullYear();    // 
        mm=d.getMonth()+1;
        dd=d.getDate();
        if (("" + mm).length == 1) { mm = "0" + mm; }
        if (("" + dd).length   == 1) { dd   = "0" + dd;   }
        currentDate = yy + mm + dd;
        return currentDate;
	}
	
	// 날짜세팅하기(formName:폼이름,field1:시작일,field2:종료일,type:(1:일,2:주,3:달),val(값)

	function goDayCalcu(formName,field1,field2,type,val)
	{
		var Day=new Date();
		var preYear;
		var preMonth;
		var preDay;
		var nowYear;
		var nowMonth;
		var nowDay;

		nowYear = Day.getYear();

		if((Day.getMonth()+1) < 9)
			nowMonth = "0"+(Day.getMonth()+1);
		else
			nowMonth = Day.getMonth()+1


		if(Day.getDate() < 10)
			nowDay = "0"+Day.getDate();
		else
			nowDay = Day.getDate();


		if(type =="1")
			Day.setDate(Day.getDate()-val);
		else if(type == "2")
			Day.setDate(Day.getDate()-(7*val));
		else if(type == "3")
			Day.setMonth(Day.getMonth()-val);


		preYear = Day.getYear();

		if((Day.getMonth()+1) < 9)
			preMonth = "0"+(Day.getMonth()+1);
		else
			preMonth = Day.getMonth()+1;

		if(Day.getDate() < 10)
			preDay = "0"+Day.getDate();
		else
			preDay = Day.getDate();

		eval('document.' + formName + '.' + field1).value = preYear+'/'+preMonth+'/'+preDay;
		eval('document.' + formName + '.' + field2).value = nowYear+'/'+nowMonth+'/'+nowDay;


	}

    // 재외국인 번호 체크
    
    function check_fgnno(fgnno) 
    {
		var sum=0;
		var odd=0;

		buf = new Array(13);

		for(i=0; i<13; i++) { buf[i]=parseInt(fgnno.charAt(i)); }

		odd = buf[7]*10 + buf[8];

		if(odd%2 != 0) { return false; }

		if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) 
			return false;
			
		multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];

		for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }

		sum = 11 - (sum%11);

		if(sum >= 10) { sum -= 10; }
		sum += 2;

		if(sum >= 10) { sum -= 10; }
		if(sum != buf[12]) { return false }

		return true;
    }

    // 사업자등록번호 체크
    
    function check_busino(vencod) 
    {
		var sum = 0;
		var getlist =new Array(10);
		var chkvalue =new Array("1","3","7","1","3","7","1","3","5");

		for(var i=0; i<10; i++) { getlist[i] = vencod.substring(i, i+1); }
		for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; }

		sum = sum + parseInt((getlist[8]*5)/10);
		sidliy = sum % 10;
		sidchk = 0;

		if(sidliy != 0) { sidchk = 10 - sidliy; }
		else { sidchk = 0; }

		if(sidchk != getlist[9]) { return false; }
		return true;
    }

	// 윤년에 해당하는 날짜인지 체크

    function isLunarDay(dateStr) 
    {
    	if(dateStr != '' && dateStr.length() == 8)
    	{
    		var year  = dateStr.substr(0, 4);
			var month = dateStr.substr(4, 6);
			var day   = dateStr.substr(6, 8);
    
            switch (month) 
            {
	            // 2월의 경우
            
	            case 2:								
    
                    if (day > 29) 
                    	return true;

                    if (day == 29) 
                    {
						// 2월 29의 경우 당해가 윤년인지를 확인

						if ((year % 4 != 0) || (year % 100 == 0) && (year % 400 != 0))
							return true;
                    }
    
                    break;

				// 30일에 해당하는 달의 경우

	            case 4:        
	            case 6:
	            case 9:
	            case 11:

                    if(d == 31) 
                    	return true;
            }
		}
		
		// 큰 달의 경우
		
		else
            return false;
    }
    
    function isNumeric(s) 
    {
		for (i=0; i<s.length; i++) 
		{
			c = s.substr(i, 1);
			if (c < "0" || c > "9") return false;
		}

		return true;
    }
    
    function getNumberOfDate(yy, mm) 
    {
            month = new Array(29,31,28,31,30,31,30,31,31,30,31,30,31);

            if (mm == 2 && isLeapYear(yy)) 
            	mm = 0;

            return month[mm];
    }

    function isLeapYear(y) 
    {
		if (y < 100)
			y = y + 1900;
		
		if ( (y % 4 == 0) && (y % 100 != 0) || (y % 400 == 0) ) 
		        return true;
		else
		        return false;
    }


	// fullLength 보다 value 의 자리수가 작을때 나머지 자리수를 0으로 채워 리턴한다.

	function makeDigitWord(value, fullLength)
	{
		if(typeof(value) != 'undefined' && value != '')
		{
			var maxValue = new String(Math.pow(10, fullLength) + new Number(value));
			value = maxValue.substring(1);
		}

		return value;
	}

	// 만나이 구하기
	function getUserFullAge(regiNum1, regiNum2)
	{
		return getUserFullAge(regiNum1 + regiNum2);
	}

	// 만나이 구하기 ('-' 없는 13자리 수)
	function getUserFullAge(regiNum)
	{
		var result = -99;

		if(regiNum.length == 13 && (new Number(regiNum)))
		{
			var nowDate		= new Date();
			var birthDate	= new Date();

			var birthYear = 0;

			if(regiNum.substring(6, 7) == '1' || regiNum.substring(6, 7) == '2')
				birthYear = new Number('19' + regiNum.substring(0, 2));
			else if(regiNum.substring(6, 7) == '3' || regiNum.substring(6, 7) == '4')
				birthYear = new Number('20' + regiNum.substring(0, 2));

			birthMonth	= (new Number(regiNum.substring(2, 4))) - 1;
			birthDay	= new Number(regiNum.substring(4, 6));

			var subYear 	= nowDate.getYear() - birthYear;
			var subMonth	= nowDate.getMonth() - birthMonth;
			var subDay		= nowDate.getDate() - birthDay;

			if(subYear > 0)
			{
				result = subYear

				if(subMonth < 0 || subDay < 0)
					result = result - 1;
			}
		}

		return result;
	}


/////////////////////////////////////////////////////////////////////////////////////////////////////// 4. 공용 펑션

	// 숫자형으로 변환

	function getNumber(value)
	{	
		var result = new Number(value);
		
		if(typeof(result) == 'NaN' || typeof(result) == 'undefined')
			result = 0;
			
		return result;	
	}
	
	// 숫자의 round 처리
	
	function rounds(value, pos)
	{
		var result = '';
	
		var valueStr = new String(value);

		if(value != '')
		{
			result = valueStr;
		
			var underPos = valueStr.indexOf(".");
	
			if(underPos != -1)
			{
				underPos = underPos + pos + 1

				if(valueStr.length >= underPos)
				{
					result = valueStr.substring(0, underPos -1);
		
					var first  = new Number(valueStr.substring(underPos - 1, underPos));
					var second = new Number(valueStr.substring(underPos, underPos + 1));
					
					if(second >= 5)
						first = first + 1;
				
					result = result + new String(first);
				}	
			}
		}
		else 
			result = 0;	

		return result;	
	}

	// 입력 필드의 값이 null 인 경우 value 값으로 치환

	function nullToValue(fields, values)
	{
		if(fields.value == '')
			fields.value = values;
	}


	//공백존재 유무 체크

	function chkTrim(val)
	{
		return / /.test(val);
	}

	//공백제거(양쪽)

	function trim(src)
	{
		var result = '';
	
		if(typeof(src) != 'undefined')
		{
			var expStr = /^\s+|\s+$/g;

			result = src.replace(expStr, "");
		}	
		
		return result;
	}
	
	function trimAll(src)
	{
		var result = '';
	
		if(typeof(src) != 'undefined')
		{
			var expStr = /\s*/g;

			result = src.replace(expStr, "");
		}	
		
		return result;
	}
	
	// 일반 url 이동

	function replaceURL(url)
	{
		document.body.innerHTML = "<form name='commonForm'></form>";

		forms = document.commonForm;

		forms.method = 'POST';
		forms.action = url;
		forms.submit();
	}

	// 괄호추가

	function insertBlace(str)
	{
		var result = '';

		if(str != '' && str != 'null')
			result = '(' + str + ')';

		document.write(result);
	}

    function WindowReset( win /* Window Object */ ){ // 새창의 크기와 위치 재설정

  	  //  사용법 : <body OnLoad="WindowReset(this)">
  	  // 새창의 진행상황 체크 완료되면 코드실행 
  	  // 
  	  //while(win.document.readyState != 'complete'){}
  	   
  	  var winBody = win.document.body; 
  	  
  	  // 
  	  // 새창의 사이즈에 더해줄 marginWidth와 marginHeight 
  	  // 
  	  var marginHeight = parseInt(winBody.topMargin)+parseInt(winBody.bottomMargin); 
  	  var marginWidth = parseInt(winBody.leftMargin)+parseInt(winBody.rightMargin); 
  	  // 
  	  // 새창의 사이즈 설정 
  	  // 
  	  var wid = winBody.scrollWidth + (winBody.offsetWidth - winBody.clientWidth) + marginWidth-50
  	  var hei = winBody.scrollHeight + (winBody.offsetHeight - winBody.clientHeight) + marginHeight+17; 
  	  // 
  	  // 사이즈 재조정 
  	  // 
  	  win.resizeTo(wid, hei); 
  	}
    
    //팝업 사이즈 자동조절
    function auto_fit_size() {
        window.resizeTo(100, 100);
        var thisX = parseInt(document.body.scrollWidth);
        var thisY = parseInt(document.body.scrollHeight);
        var maxThisX = screen.width - 50;
        var maxThisY = screen.height - 50;
        var marginY = 0;
        //alert(thisX + "===" + thisY);
        //alert("임시 브라우저 확인 : " + navigator.userAgent);
        // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
        if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 60;        // IE 6.x
        else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 80;    // IE 7.x
        else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
        else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
        else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape

        if (thisX > maxThisX) {
            window.document.body.scroll = "yes";
            thisX = maxThisX;
        }
        if (thisY > maxThisY - marginY) {
            window.document.body.scroll = "yes";
            thisX += 19;
            thisY = maxThisY - marginY;
        }
        window.resizeTo(thisX+10, thisY+marginY);
    }
//-->