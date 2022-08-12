var Param = document.createElement('PARAM');
Param.name = "Language";
Param.value = SELECTED_LANGUAGE;
WatSearCtrl.appendChild(Param);
var Param = document.createElement('PARAM');
Param.name = "URL";
Param.value = document.location;
WatSearCtrl.appendChild(Param);

var sDISCONNECTED = 0;
var sCONNECTED = 1;
var sDISCONNECTING = 2;
var sCONNECTING = 3;
var gConnectStatus = sDISCONNECTED;

var enableChangePage = false;

function isConnected()
{
	return (gConnectStatus == sCONNECTED) ? true : false;
}

function isConnecting()
{
	return (gConnectStatus == sCONNECTING) ? true : false;
}

function isDisconnected()
{
	return (gConnectStatus == sDISCONNECTED) ? true : false;
}

function isDisconnecting()
{
	return (gConnectStatus == sDICONNECTING) ? true : false;
}