<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>폼확인</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		   function form_check(){
			 
			   if($("#userid").val().length==0){
				   alert("데이터를 입력해주세요.");
				   $("#userid").focus();
			   } 
			   
			   
			   var idPattern = /^[A-Z]{1}[a-zA-Z0-9]{7,14}$/;
			   var pwPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+|\<>?]).{2,}$/;

			   
			   if($("#upw").val()!=$("#upw2").val()){
				   alert("비밀번호가 일치하지 않습니다.");
			   }
			   
			   
			   if(idPattern.test($("#userid").val())!=true){
				   alert("입력한 id가 영문자,숫자가 아닙니다.");
				   return false;
			   }
			   
			   if(pwPattern.test($("#upw").val())!=true){
				   alert("영문,숫자,특수문자가 1개이상 입력이 되어야 합니다.");
				   return false;
			   }else{
				   alert("정상적으로 입력했습니다.");
			   }
			   
			   
			   
			   
			   
			   
			   
			   
			   //return member_form.submit();
			   
		   }
		
		</script>
		
	</head>
	<body>
	  <h3>회원가입</h3>
	  <form action="./memberInsert" name="member_form" method="post">
	    <label for="userid">아이디</label>
	    <input type="text" id="userid" name="userid"><br>
	    <label for="upw">비밀번호</label>
	    <input type="text" id="upw" name="upw"><br>
	    <label for="upw2">비밀번호확인</label>
	    <input type="text" id="upw2" name="upw2"><br>
	    <label for="uname">이름</label>
	    <input type="text" id="uname" name="uname"><br>
	    <label for="unname">닉네임</label>
	    <input type="text" id="unname" name="unname"><br>
	    <label for="utel">전화번호</label>
	    <input type="text" id="utel" name="utel"><br>
	    <label for="uzipcode">우편번호</label>
	    <input type="text" id="uzipcode" name="uzipcode">
	    <button onclick="">우편번호 검색</button>
	    <br>
	    <label for="uaddress1">주소1</label>
	    <input type="text" id="uaddress1" name="uaddress1"><br>
	    <label for="uaddress2">주소2</label>
	    <input type="text" id="uaddress2" name="uaddress2"><br>
	    <label for="ubirth">생년월일</label>
	    <input type="text" id="ubirth" name="ubirth"><br>
	    <input type="button" onclick="form_check()" value="전송">
	    <input type="reset" value="취소"><br>
	  </form>
	
	</body>
</html>