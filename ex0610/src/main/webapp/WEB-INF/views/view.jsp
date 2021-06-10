<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>뷰페이지</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/read.css">
  <script type="text/javascript">
    function delete_check(){
    	if(confirm("삭제하시겠습니까?")){
    		location.href="./delete?bno="+${mvc_board.bno};
    	}else{
    		return false;
    	}
    }
  </script>
</head>
<body>
<section>
    <h1>NOTICE</h1>

    <table>
      <colgroup>
        <col width="80%">
        <col width="10%">
        <col width="10%">
        
      </colgroup>
      <tr>
        <th colspan="3">제목<span class="separator">|</span> ${map.mvc_board.btitle }</th>
      </tr>
      <tr>
        <td colspan="3"><strong>작성일</strong><span class="separator">|</span> ${map.mvc_board.bdate }</td>
      </tr>
      <tr>
        <td><strong>작성자</strong><span class="separator">|</span> ${map.mvc_board.userid }</td>
        <td><strong>조회수</strong></td>
        <td>${map.mvc_board.bhit }</td>
      </tr>
      <tr>
        <td colspan="3" class="article">${map.mvc_board.bcontent }</td>
      </tr>
      <tr>
        <td colspan="3" class="article">
          <img src="http://localhost:8000/upload/${map.mvc_board.fileName}">
        </td>
      </tr>
      <tr>
        <td colspan="3"><strong>다음글</strong> <span class="separator">|</span> [공지] ${map.boardPre.btitle }</td>
      </tr>
      <tr>
        <td colspan="3"><strong>이전글</strong> <span class="separator">|</span> [공지] ${map.boardNext.btitle }</td>
      </tr>
    </table>

    <a href="./list"><div class="list">목록</div></a>
    <div class="list" onclick="delete_check()">삭제</div>
    <a href="./modify?bno=${map.mvc_board.bno}"><div class="list">수정</div></a>
    <a href="./reply?bno=${map.mvc_board.bno}"><div class="list">답변달기</div></a>
  </section>
</body>
</html>