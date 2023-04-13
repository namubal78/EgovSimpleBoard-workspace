<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
		<jsp:forward page="mainList.bo" /> <!-- 메인 페이지로 포워딩 
		이제 index.jsp 에서 포워딩 하지 않고 WEB-INF 아래에서 바로 main.jsp 로 웰컴 파일 리스트를 작성함
		왜냐면 주소창에서도 /main.jsp 를 치고 들어올 수 있어야 하니까
	-->
	
</body>
</html>