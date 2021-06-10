<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<c:if test="${session_flag==null || session_flag=='fail'}">
  <script type="text/javascript">
    alert("로그인을 하셔야 페이지 확인이 가능합니다.");
    location.href="../index";
  </script>
</c:if>    
<title> JARDIN SHOP </title>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="JARDIN SHOP" />
<meta name="keywords" content="JARDIN SHOP" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scaleable=no" />
<link rel="stylesheet" type="text/css" href="../css/reset.css?v=Y" />
<link rel="stylesheet" type="text/css" href="../css/layout.css?v=Y" />
<link rel="stylesheet" type="text/css" href="../css/content.css?v=Y" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/top_navi.js"></script>
<script type="text/javascript" src="../js/left_navi.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="../js/idangerous.swiper-2.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.anchor.js"></script>
<script type="text/javascript">

  /* 댓글 취소 */
  function cancelReply_ajax(replyNo,userid,replyContent,replyDate){
	 alert("댓글취소 테스트"); 
	 var html=""
	 html = html + "<li class='name'>"+userid+"&nbsp;&nbsp;<span>["+replyDate+"]</span></li>";
	 html = html + "<li class='txt'>"+replyContent+"</li>";
	 html = html + "<li class='btn'>";
	 html = html + "<a onclick=\"updateformReply_ajax("+replyNo+",'"+userid+"','"+replyContent+"','"+replyDate+"')\" class='rebtn'>수정</a>&nbsp;";
	 html = html + "<a onclick=\"deleteReply_ajax('"+replyNo+"')\" class='rebtn'>삭제</a>";
	 html = html + "</li>";
	 $('#'+replyNo).html(html);
	 
  }
  


  /* 댓글수정저장 완료 */
  function updateReply_ajax(replyNo,userid){
	  alert("댓글수정저장 테스트");
	  
	  $.ajax({
			 url:'./replyUpdate',     
			 type:'post',
			 data:{
				 "replyNo":replyNo,
				 "bno":1,
				 "userid":userid, 
				 "replyContent":$("#replyUpdateContent").val()
			 },
			 success:function(data){
				 alert("data replyVo : "+data.replyNo);
				 var html="";
				 // 댓글의 번호를 통해 데이터 수정,삭제를 하기 위해
				 html = html + "<li class='name'>"+data.userid+"&nbsp;&nbsp;<span>["+data.replyDate+"]</span></li>";
				 html = html + "<li class='txt'>"+data.replyContent+"</li>";
				 html = html + "<li class='btn'>";
				 html = html + "<a onclick=\"updateformReply_ajax("+data.replyNo+",'"+data.userid+"','"+data.replyContent+"','"+data.replyDate+"')\" class='rebtn'>수정</a>&nbsp;";
				 html = html + "<a onclick=\"deleteReply_ajax("+data.replyNo+")\" class='rebtn'>삭제</a>";
				 html = html + "</li>";
				 $('#'+replyNo).html(html);
			 },
			 error:function(){
				 alert("에러");
			 }
		  });
  }


  /* 댓글수정창 변경 - cancel처리하면 완료*/
  function updateformReply_ajax(replyNo,userid,replyContent,replyDate){
	  alert("update테스트 : "+replyNo);
	  var html ="";
	  html = html + "<li class='name'>"+userid+" <span>[ "+replyDate+" ]</span></li>";
	  html = html + "<li class='txt'><textarea id='replyUpdateContent' class='replyType'>"+replyContent+"</textarea></li>";
	  html = html + "<li class='btn'>";
	  html = html + "<a onclick=\"updateReply_ajax("+replyNo+",'"+userid+"'"+")\" class='rebtn'>저장</a>";
	  html = html + "<a onclick=\"cancelReply_ajax("+replyNo+",'"+userid+"','"+replyContent+"','"+replyDate+"'"+")\" class='rebtn'>취소</a>";
	  html = html + "</li>";
	  $('#'+replyNo).html(html);
  }


  /* 댓글 추가 완료 */
  function reply_ajax(){

	  if($("#replyContent").val()=="" ||$("#replyContent").val()==null ){
		  alert("데이터를 입력해주세요.");
		  return false;
	  }
	  
	  $.ajax({
		 url:'./replyInsert',     
		 type:'post',
		 data:{
			 "userid":"${session_id}", //
			 "bno":1,
			 "replyPw":$("#replyPw").val(),
			 "replyContent":$("#replyContent").val()
		 },
		 success:function(data){
			 alert("data test  : "+data.replyCount);
			 alert("data replyVo : "+data.replyVo.replyNo);
			 var html="";
			 var id = "${session_id}";
			 // 댓글의 번호를 통해 데이터 수정,삭제를 하기 위해
			 html = html + "<ul id='"+data.replyVo.replyNo+"'>";
			 html = html + "<li class='name'>"+id+"&nbsp;&nbsp;<span>["+data.replyVo.replyDate+"]</span></li>";
			 html = html + "<li class='txt'>"+data.replyVo.replyContent+"</li>";
			 html = html + "<li class='btn'>";
			 html = html + "<a onclick=\"updateformReply_ajax("+data.replyVo.replyNo+",'"+data.replyVo.userid+"','"+data.replyVo.replyContent+"','"+data.replyVo.replyDate+"')\" class='rebtn'>수정</a>&nbsp;";
			 html = html + "<a onclick=\"deleteReply_ajax('"+data.replyVo.replyNo+"')\" class='rebtn'>삭제</a>";
			 html = html + "</li></ul>";
			 
			 $(".replyBox").prepend(html);
			 $("#replyCount").text(data.replyCount);
			 $("#replyPw").val("");
			 $("#replyContent").val("");
		 },
		 error:function(){
			 alert("에러");
		 }
	  });
  }
  
  /* 댓글 삭제 완료 */
  function deleteReply_ajax(replyNo){
	  alert("삭제 테스트");
	  alert("replyNo : "+replyNo);
	  if(confirm("댓글을 삭제하시겠습니까?")){
		  $.ajax({
				 url:'./deleteReply',     
				 type:'post',
				 data:{
					 "replyNo":replyNo,
				 },
				 success:function(data){
					 alert("data msg : "+data.msg);
					 var html="";
					 $("#replyCount").text(data.replyCount);
					 // text -> 글자만 넣음. html -> 기존html삭제후 추가
					 // prepend-> 앞에 넣음. expend->뒤에 넣음. remove->해당html삭제
					 $('#'+replyNo).remove();
				 },
				 error:function(){
					 alert("에러");
				 }
		  });
	  }else{ return false; }
  }



</script>
<style type="text/css">
  a, button{cursor:pointer; }
</style>



</head>
<body>
<div id="allwrap">
<div id="wrap">

	<div id="header">
		
		<div id="snbBox">
			<h1><img src="../images/txt/logo.gif" alt="JARDIN SHOP" /></h1>
			<div id="quickmenu">
				<div id="mnaviOpen"><img src="../images/btn/btn_mnavi.gif" width="33" height="31" alt="메뉴열기" /></div>
				<div id="mnaviClose"><img src="../images/btn/btn_mnavi_close.gif" width="44" height="43" alt="메뉴닫기" /></div>
				<ul>
					<li><a href="#">EVENT</a></li>
					<li><a href="#">CUSTOMER</a></li>
					<li><a href="#">COMMUNITY</a></li>
				</ul>
			</div>
			<div id="snb">
				<ul>
					<li><a href="#">LOGIN</a></li>
					<li><a href="#">JOIN</a></li>
					<li><a href="#">MY PAGE</a></li>
					<li><a href="#">CART</a></li>
				</ul>

				<div id="search">
					<input type="text" class="searchType" />
					<input type="image" src="../images/btn/btn_main_search.gif" width="23" height="20" alt="검색하기" />
				</div>
			</div>
		</div>
	</div>


	<!-- GNB -->
	<div id="gnb">
		
		<div id="top">
			<ul>
				<li class="brand t1"><a href="#" id="topNavi1">JARDIN’s BRAND</a>
					<ul id="topSubm1">
						<li><a href="#">클래스</a></li>
						<li><a href="#">홈스타일 카페모리</a></li>
						<li><a href="#">드립커피백</a></li>
						<li><a href="#">카페리얼 커피</a></li>
						<li><a href="#">오리지널커피백</a></li>
						<li><a href="#">카페리얼 음료</a></li>
						<li><a href="#">마일드커피백</a></li>
						<li><a href="#">워터커피</a></li>
						<li><a href="#">카페포드</a></li>
						<li><a href="#">모히또파티</a></li>
						<li><a href="#">테이크아웃 카페모리</a></li>
						<li><a href="#">포타제</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi2">원두</a>
					<ul id="topSubm2">
						<li><a href="#">클래스</a></li>
						<li><a href="#">로스터리샵</a></li>
						<li><a href="#">커피휘엘</a></li>
						<li><a href="#">산지별 생두</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi3">원두커피백</a>
					<ul id="topSubm3">
						<li><a href="#">드립커피 로스트</a></li>
						<li><a href="#">오리지널커피백</a></li>
						<li><a href="#">마일드커피백</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi4">인스턴트</a>
					<ul id="topSubm4">
						<li><a href="#">까페모리</a></li>
						<li><a href="#">홈스타일카페모리</a></li>
						<li><a href="#">포타제</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi5">음료</a>
					<ul id="topSubm5">
						<li><a href="#">까페리얼</a></li>
						<li><a href="#">워터커피</a></li>
						<li><a href="#">모히또</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi6">커피용품</a>
					<ul id="topSubm6">
						<li><a href="#">종이컵</a></li>
						<li><a href="#">커피필터</a></li>
						<li><a href="#">머신 등</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi7">선물세트</a></li>
				<li class="t2"><a href="#" id="topNavi8">대량구매</a></li>
			</ul>
		</div>

		<script type="text/javascript">initTopMenu();</script>
	</div>
	<!-- //GNB -->

	<!-- container -->
	<div id="container">

		<div id="location">
			<ol>
				<li><a href="#">HOME</a></li>
				<li><a href="#">EVENT</a></li>
				<li class="last">진행중 이벤트</li>
			</ol>
		</div>
		
		<div id="outbox">		
			<div id="left">
				<div id="title2">EVENT<span>이벤트</span></div>
				<ul>	
					<li><a href="#" id="leftNavi1">진행중 이벤트</a></li>
					<li><a href="#" id="leftNavi2">종료된 이벤트</a></li>
					<li class="last"><a href="#" id="leftNavi3">당첨자 발표</span></a></li>
				</ul>			
			</div><script type="text/javascript">initSubmenu(1,0);</script>


			<!-- contents -->
			<input type="hidden" id="bno" value="1"> 
			<div id="contents">
				<div id="mypage">
					<h2><strong>진행중 이벤트</strong><span>쟈뎅샵의 특별한 혜택이 가득한 이벤트에 참여해 보세요.</span></h2>
					
					<div class="viewDivMt">
						<div class="viewHead">
							<div class="subject">
								<ul>
									<li>까페모리 봄바람 커피한잔 30% 할인 이벤트!!</li>
								</ul>
							</div>
							<div class="day">
								<p class="txt">이벤트 기간<span>2014-04-01 ~ 2014-04-29</span></p>
							</div>
						</div>

						<div class="viewContents">
							<img src="../images/img/sample_event_view.jpg" alt="" />
						</div>
					</div>


					<!-- 이전다음글 -->
					<div class="pnDiv web">
						<table summary="이전다음글을 선택하여 보실 수 있습니다." class="preNext" border="1" cellspacing="0">
							<caption>이전다음글</caption>
							<colgroup>
							<col width="100px" />
							<col width="*" />
							<col width="100px" />
							</colgroup>
							<tbody>
								<tr>
									<th class="pre">PREV</th>
									<td><a href="#">상품 재입고는 언제 되나요?</a></td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<th class="next">NEXT</th>
									<td>다음 글이 없습니다.</td>
									<td>&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- //이전다음글 -->





					<!--   댓글내용    -->
					<div class="replyWrite">
						<ul>
							<li class="in">
								<p class="txt">총 <span id="replyCount" class="orange">${map.replyCount }</span> 개의 댓글이 달려있습니다.</p>
								<!-- 입력 -->
								<p class="password">비밀번호&nbsp;&nbsp;<input type="password" id="replyPw" class="replynum" /></p>
								<textarea id="replyContent" class="replyType"></textarea>
							</li>
							<li class="btn"><button type="button" onclick="reply_ajax()" class="replyBtn">등록</button></li>
						</ul>
						<p class="ntic">※ 비밀번호를 입력하시면 댓글이 비밀글로 등록 됩니다.</p>
					</div>



					<div class="replyBox">
						<!-- 댓글수정창입니다. --> 
						<!-- <ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt"><textarea class="replyType"></textarea></li>
							<li class="btn">
								<a href="#" class="rebtn">수정</a>
								<a href="#" class="rebtn">삭제</a>
							</li>
						</ul> -->


                        <!-- 댓글 for문 시작 -->
                        <c:forEach var="replyVo" items="${map.replyList}">
                        <ul id="${replyVo.replyNo }">
							<li class="name">${replyVo.userid} <span>[ ${replyVo.replyDate } ]</span></li>
							<li class="txt">${replyVo.replyContent }</li>
							<%-- id가 일치하면 버튼생성 --%>
							<c:if test="${session_id == replyVo.userid}">
								<li class="btn">
									<a onclick="updateformReply_ajax('${replyVo.replyNo }','${replyVo.userid}',
									'${replyVo.replyContent}','${replyVo.replyDate }')" class="rebtn">수정</a> 
									<a onclick="deleteReply_ajax('${replyVo.replyNo}')" class="rebtn">삭제</a>
								</li>
							</c:if>
						</ul>
                        </c:forEach>
						<!-- 댓글 for문 끝 -->
						  
						<ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt">대박!!! 이거 저한테 완전 필요한 이벤트였어요!!</li>
							<li class="btn">
								<a onclick="updateReply_ajax()" class="rebtn">수정</a>
								<a href="#" class="rebtn">삭제</a>
							</li>
						</ul>

						<ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt">
								<a href="password.html" class="passwordBtn"><span class="orange">※ 비밀글입니다.</span></a>
							</li>
						</ul>
					</div>
					<!-- //댓글 -->


					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bRight">
							<ul>
								<li><a href="#" class="sbtnMini mw">목록</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->
					
				</div>
			</div>
			<!-- //contents -->


<script type="text/javascript" src="../js/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="../css/jquery.fancybox-1.3.4.css" />
<script type="text/javascript">
$(function(){
	
	var winWidth = $(window).width();
	if(winWidth > 767){
		var layerCheck = 540;
	}else{
		var layerCheck = 320;
	}

	$(".passwordBtn").fancybox({
		'autoDimensions'    : false,
		'showCloseButton'	: false,
		'width' : layerCheck,
		'padding' : 0,
		'type'			: 'iframe',
		'onComplete' : function() {
			$('#fancybox-frame').load(function() { // wait for frame to load and then gets it's height
			$('#fancybox-content').height($(this).contents().find('body').height());
			});
		}
	});


});
</script>

		</div>
	</div>
	<!-- //container -->




	<div id="footerWrap">
		<div id="footer">
			<div id="fnb">
				<ul>
					<li class="left"><a href="#">개인정보취급방침</a></li>
					<li><a href="#">이용약관</a></li>
					<li class="left"><a href="#">이메일무단수집거부</a></li>
					<li><a href="#">고객센터</a></li>
					<li class="left brand"><a href="#">쟈뎅 브랜드 사이트</a></li>
				</ul>
			</div>
			
			<div id="finfo">
				<div id="flogo"><img src="../images/txt/flogo.gif" alt="JARDIN THE COFFEE CREATOR, SINCE 1984" /></div>
				<address>
					<ul>
						<li>㈜쟈뎅</li>
						<li>대표자 윤영노</li>
						<li class="tnone">주소 서울시 강남구 논현동 4-21번지 영 빌딩</li>
						<li class="webnone">소비자상담실 02)546-3881</li>
						<li>사업자등록번호 211-81-24727</li>
						<li class="tnone">통신판매신고 제 강남 – 1160호</li>
						<li class="copy">COPYRIGHT © 2014 JARDIN <span>ALL RIGHTS RESERVED.</span></li>
					</ul>
				</address>

				<div id="inicis"><img src="../images/ico/ico_inicis.png" alt="이니시스 결제시스템" /></div>
			</div>
		</div>
	</div>



</div>
</div>
</body>
</html>