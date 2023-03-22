<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
<style>
	/* div{border:1px solid red;} */
	#footer {
	    width:80%;
	    height:200px;
	    margin:auto;
	    margin-top:50px;
	}
	#footer-1 {
	    width:100%;
	    height:20%;
/* 	    border-top:1px solid lightgray; */
	    border-bottom:1px solid lightgray;
	}
	#footer-2 {width:100%; height:80%;}
	#footer-1>a {
	    text-decoration:none;
	    font-weight:600;
	    margin:10px;
	    line-height:40px;
	    color:black;
	}
	#footer-2>p {
	    margin:0;
	    padding:10px;
	    font-size:13px;
	}
	#p2 {text-align:center;}
</style>
</head>
<body>

	<div id="footer">
        <div id="footer-1">
            <a href="/"><img src="images/logo-dark.png" alt="logo"></a>
        </div>

        <div id="footer-2">
            <p id="p1">
				서울 서초구 바우뫼로 220 일광빌딩 3층 / Tel: 02-572-3673~4 / Fax: 02-572-3675<br>
				법인명 : (주)지에이시스템 / 대표자 : 전상구 / 사업자번호 : 214-86-79736 / 통신판매번호 : 2002-서울서초-01753<br>
				Copyright ⓒ GASYSTEM Co., Ltd All rights reserved. Since 2001.04.10
            </p>
        </div>
    </div>

</body>
</html>