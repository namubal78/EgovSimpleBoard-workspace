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

    #boardList {text-align:center;}

	/* The switch - the box around the slider */
	.switch {
	  position: relative;
	  display: inline-block;
	  width: 60px;
	  height: 34px;
	  vertical-align:middle;
	}
	
	/* Hide default HTML checkbox */
	.switch input {display:none;}
	
	/* The slider */
	.slider {
	  position: absolute;
	  cursor: pointer;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: #ccc;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	.slider:before {
	  position: absolute;
	  content: "";
	  height: 26px;
	  width: 26px;
	  left: 4px;
	  bottom: 4px;
	  background-color: white;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	input:checked + .slider {
	  background-color: #2196F3;
	}
	
	input:focus + .slider {
	  box-shadow: 0 0 1px #2196F3;
	}
	
	input:checked + .slider:before {
	  -webkit-transform: translateX(26px);
	  -ms-transform: translateX(26px);
	  transform: translateX(26px);
	}
	
	/* Rounded sliders */
	.slider.round {
	  border-radius: 34px;
	}
	
	.slider.round:before {
	  border-radius: 50%;
	}
	
	p {
		margin:0px;
		display:inline-block;
		font-size:15px;
	}    
	
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>게시판 관리</h2>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                    	<td style="width: 1px;"></td>
                        <th style="width: 400px;">게시판</th>
                        <th style="width: 200px;">공개</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="b" items="${ list }">
                		<tr>
                			<td style="width: 1px;"><input type="hidden" name="boardNo" value="${ b.boardNo }"></td>
	                        <td style="width: 400px;">${ b.boardName }</td>
	                        <td style="width: 200px;">
	                        	<c:choose>
	                        		<c:when test="${ b.boardOpen eq 'Y' }">
	                        			<label class="switch">
											<input type="checkbox" checked>
										  	<span class="slider round"></span>
										</label>
	                        		</c:when>
	                        		<c:otherwise>
	                        			<label class="switch">
											<input type="checkbox">
										  	<span class="slider round"></span>
										</label>
	                        		</c:otherwise>
	                        	</c:choose>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
<!--             <script> -->
            
//             	let bno = $(this).parent().parent().parent().children().eq(0).children().val()
            
// 	            var check = $("input[type='checkbox']");
            
// 	            check.click(function(){
	            	
// 	            	if($(this).attr('checked') == false) {

// 	            		ajaxUnopenBoard(bno);
// 	            	} else if($(this).attr('checked') == true) {
	            		
// 	            		ajaxOpenBoard(bno);
// 	            	} else {
	            		
// 	            	}
	            		            	
// // 					console.log($(this).parent().parent().parent().children().eq(0).children().val());
//  	            });
	            
// 				function ajaxOpenBoard() {
					
// 					console.log("open도착");
					
// 					$.ajax({
// 						url: "ajaxOpenBoard.co",
// 						data: {bno:bno},
// 						success: function(result) {
							
// 						},
// 						error: function() {
// 							console.log("게시판관리용 ajax 통신 실패!");
// 						}
// 					});
// 				}
				
// 				function ajaxUnopenBoard() {
					
// 					console.log("upopen도착");

// 					$.ajax({
// 						url: "ajaxUnopenBoard.co",
// 						data: {bno:bno},
// 						success: function(result) {
							
// 						},
// 						error: function() {
// 							console.log("게시판관리용 ajax 통신 실패!");
// 						}
// 					});
// 				}
            
<!--             </script> -->
            
            <br clear="both"><br>

    </div>

	<jsp:include page="../common/footer.jsp" />
	

</body>
