<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>

    #content {
        height: 600px;
        width: 800px;
        margin: auto;
        padding: 5px;
    }

    #content>div {
        width: 100%;
        height: 50%;
    }
    
    #content>div>p {
    	font-weight: bold;
    }
    
	#subBoardList, #boardList>tbody>tr:hover {
		cursor: pointer;
	}

</style>
</head>
<body>

	<jsp:include page="common/header.jsp" />
	
	<div id="content">
		<br><br><br>
        <div id="recentSubBoard">
            <p>최근 공지사항</p>
            <table id="subBoardList" class="table table-hover" align="center">
                <tbody>
                	<c:forEach var="sub" items="${ subList }" begin="0" end="2">
                		<tr>
                			<td style="width: 1px;"><input type="hidden" name="subBno" value="${ sub.subBoardNo }"></td>
	                        <td style="width: 500px;">${ sub.subBoardTitle }</td>
	                        <td style="width: 200px; text-align: right;">${ sub.subBoardDate }</td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#subBoardList>tbody>tr").click(function(){
            			location.href = "detail.sub?subBno=" + $(this).children().eq(0).children().eq(0).val();
            		});
            	});	
            </script>
        </div>

        <div id="recentBoard">
            <p>최근 게시글</p>
            <table id="boardList" class="table table-hover" align="center">

                <tbody>
                	<c:forEach var="b" items="${ list }" begin="0" end="2">
                		<tr>
                			<td style="width: 1px;"><input type="hidden" name="bno" value="${ b.boardNo }"></td>
                		    <td style="width: 500px;">${ b.boardTitle }</td>
	                        <td style="width: 200px; text-align: right;">${ b.boardDate }</td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#boardList>tbody>tr").click(function(){
            			location.href = "detail.bo?bno=" + $(this).children().eq(0).children().eq(0).val();
            		});
            	});	
            </script>
        </div>
	
	<br><br>
	</div>
	
	<jsp:include page="common/footer.jsp" />

</body>
</html>