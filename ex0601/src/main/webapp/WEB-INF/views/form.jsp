<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>form</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
		   function form_ajax(){
			   alert("아이디 : "+ $("#id").val());
			   
			   $.ajax({
				 url:"formOk",
				 type:"post",
				 data:{ // data->controller->db->다시 data전달받기를 원함
					 "id":$("#id").val(),"pw":$("#pw").val(),
					 "name":$("#name").val(),"nicName":$("#nicName").val()
				 },
				 success:function(data){
					 alert("성공 : "+data.id);
				 },
				 error:function(){
					 alert("실패");
				 }
			   });
		   }
		
		</script>
		
		
		<style type="text/css">
		   table,th,td{border: 1px solid black; border-collapse:collapse; }
		</style>
	</head>
	<body>
	   <h3>회원가입</h3>
	   <form action="formOk" method="post" name="form">
		   <label for="id">아이디</label>
		   <input type="text" name="id" id="id" placeholder="아이디는 8자리 입력"><br>
		   <label for="pw">비밀번호</label>
		   <input type="text" name="pw" id="pw" placeholder="비밀번호는 필수입니다."><br>
		   <label for="name">이름</label>
		   <input type="text" name="name" id="name" ><br>
		   <label for="nicName">닉네임</label>
		   <input type="text" name="nicName" id="nicName" ><br>
		   <input type="button" onclick="form_ajax()" value="전송">
		   <input type="reset" value="취소"><br>
	   </form>
	   
	   <p>-----------------------------</p>
	   <table>
	      <tr>
	        <th>번호</th>
	        <th>아이디</th>
	        <th>비밀번호</th>
	        <th>이름</th>
	        <th>닉네임</th>
	      </tr>
	      <tbody>
		      <tr>
		        <td>1</td>
		        <td>admin</td>
		        <td>1234</td>
		        <td>홍길동</td>
		        <td>길동스</td>
		      </tr>
	      </tbody>
	   
	   
	   </table>
	   
	   
	   
	
	</body>
</html>