<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>게시판</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/notice_list.css">
</head>
<body>
<section>
    <h1>NOTICE 총게시글 수 : ${map.listCount }</h1>
    <div class="wrapper">
      <form action="./list" name="search" method="post">
        <select name="category" id="category">
          <option value="all" ${(map.category eq 'all')? 'selected':'' }>전체</option>
          <option value="btitle" ${(map.category eq 'btitle')? 'selected':'' }>제목</option>
          <option value="bcontent" ${(map.category eq 'bcontent')? 'selected':'' }>내용</option>
        </select>

        <div class="title">
          <input type="text" size="16" name="search" id="search" value="${map.search }">
        </div>
  
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
    </div>

    
    <table>
      <colgroup>
        <col width="10%">
        <col width="48%">
        <col width="15%">
        <col width="15%">
        <col width="12%">
      </colgroup>
      <!-- 제목부분 -->
      <tr>
        <th>No.</th>
        <th>제목</th>
        <th>작성일</th>
        <th>작성자</th>
        <th>조회수</th>
      </tr>
      <!-- 내용부분 시작 -->
      <c:forEach var="boardVo" items="${map.list }">
	      <tr>
	        <td><span class="table-notice">${boardVo.bno }</span></td>
	        <td class="table-title">
	        <!-- content_view?번호를 전달 -->
		    <a href="view?bno=${boardVo.bno }">
		        <c:forEach begin="1" end="${boardVo.bindent}">
		        <img alt="" src="./images/icon_reply.png"></c:forEach>
			    ${boardVo.btitle }
		    </a>
	        </td>
	        <td>${boardVo.bdate}</td>
	        <td>${boardVo.userid}</td>
	        <td>${boardVo.bhit}</td>
	      </tr>
      </c:forEach>
      <!-- 내용부분 끝 -->
    </table>

    <!-- 하단 넘버링 -->
    <ul class="page-num">
      <a href="./list?page=1&category=${map.category}&search=${map.search}"><li class="first"></li></a>
      <!-- 이전페이지는 1이상일때 -1을 해줌, 1일때는 링크 삭제시킴 -->
      <c:if test="${map.page<=1 }">
        <li class="prev"></li>
      </c:if>
      <c:if test="${map.page>1}">
        <a href="./list?page=${map.page-1 }&category=${map.category}&search=${map.search}"><li class="prev"></li></a>
      </c:if>
      
      <!-- 번호넣기 -->
      <c:forEach var="nowPage" begin="${map.startPage}" end="${map.endPage }">
        <c:if test="${map.page == nowPage }">
          <li class="num"><div>${nowPage}</div></li>
        </c:if>
        <c:if test="${map.page != nowPage }">
          <li class="num">
            <a href="./list?page=${nowPage}&category=${map.category}&search=${map.search}"><div>${nowPage}</div></a>
          </li>
        </c:if>
      </c:forEach>
      <!-- 다음페이지는 max보다 작을때 +1 증가, max보다 크거나 같을때 링크 삭제시킴 -->
      <c:if test="${map.page>=map.maxPage }">
        <li class="next"></li>
      </c:if>
      <c:if test="${map.page<map.maxPage }">
        <a href="./list?page=${map.page+1 }&category=${map.category}&search=${map.search}"><li class="next"></li></a>
      </c:if>
      <!-- 마지막페이지 이동 -->
      <a href="./list?page=${map.maxPage }&category=${map.category}&search=${map.search}"><li class="last"></li></a>
    </ul>
    <!-- 하단 넘버링 끝 -->

    <a href="write"><div class="write">쓰기</div></a>
  </section>

</body>
</html>