<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jQuery library (served from Google) -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<!-- bxSlider Javascript file -->
<script src="/js/jquery.bxslider.min.js"></script>
<!-- bxSlider CSS file -->
<link href="/lib/jquery.bxslider.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$('.bxslider').bxSlider({
	  mode:'horizontal', //default : 'horizontal', options: 'horizontal', 'vertical', 'fade'
	  speed:1000, //default:500 이미지변환 속도
	  auto: true, //default:false 자동 시작
	  captions: true, // 이미지의 title 속성이 노출된다.
	  autoControls: true, //default:false 정지,시작 콘트롤 노출, css 수정이 필요
	});
</script>
</head>
<body>
<ul class="bxslider">
  <li><img src="/images/pic1.jpg" title="caption value pic1"/></li>
  <li><img src="/images/pic2.jpg" title="caption value pic2"/></li>
  <li><img src="/images/pic3.jpg" title="caption value pic3"/></li>
  <li><img src="/images/pic4.jpg" title="caption value pic4"/></li>
</ul>

</body>
</html>