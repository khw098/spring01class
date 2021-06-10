<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        body{
            position: relative;
            height: 100%;
            background: #f5f6f7;
        }
        #wrap{
            position: relative;
            min-height: 100%;
            font-size: 12px;
        }
        #header{
            position: relative;
            box-sizing: border-box;
            height: 168px;
            padding: 62px 0 0;
            width: 768px;
            margin: 0 auto;
        }

        #h_logo{
            display: block;
            overflow: hidden;
            width: 231px;
            height: 44px;
            margin: 0 auto;
            font-size: 15px;
            color: transparent;
            background: url("https://static.nid.naver.com/images/ui/login/pc_sp_login_190522.png") no-repeat -1px -1px;
        }
        #container{
            padding-bottom: 50px;
            min-height: 185px;
        }
        #content{
            width: 460px;
            margin: 0 auto;
            padding-bottom: 30px;
        }
        .id_area{
            position: relative;
        }
        .input_row{
            position: relative;
            height: 29px;
            margin: 0 0 14px;
            padding: 10px 35px 10px 15px;
            border: solid 1px #dadada;
            background: #fff;
        }
        .input_box{
            display: block;
            overflow: hidden;
        }

        .int{
            font-size: 15px;
            line-height: 16px;
            position: relative;
            z-index: 9;
            width: 100%;
            height: 16px;
            padding: 7px 0 6px;
            color: #000;
            border: none;
            background: #fff;
            appearance: none;
        }
        .btn_login{
            display: block;
            width: 100%;
            height: 61px;
            margin:30px 0 14px;
            padding-top: 1px;
            border: none;
            background: #03c75a;
            text-align: center;
            color: #fff;
            font-size: 20px;
            font-weight: 700;
            line-height: 61px;
            cursor: pointer;
        }
    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
       function login_ajax(){
    	   $.ajax({
    			 url:'./login_ajax',
    			 type:'post',
    			 data:{
    				 "userid":$("#userid").val(),
    				 "upw":$("#upw").val()
    			 },
    			 success:function(data){
    				 alert(data.msg);
    				 if(data.flag=="success"){
    				    location.href="./index";
    				 }else{
    					 $("#userid").val(""); //공백처리 
    					 $("#upw").val("");
    					return false;
    				 }
    			 },
    			 error:function(){
    				 alert("에러");
    			 }
    		  });
       }
    </script>

</head>
<body>
<div id="wrap">
    <div id="header">
        <h1>
            <a href="#" id="h_logo"></a>
        </h1>
    </div>
    <div id="container">
        <div id="content">
            <div style="margin-bottom: 7px"></div>
            <form action="" method="get">
                <fieldset style="border: 0">
                    <div class="id_area">
                        <div class="input_row" id="id_area">
                            <span class="input_box">
                                <input type="text" name="userid" id="userid" class="int" placeholder="아이디">
                            </span>
                        </div>
                    </div>
                    <div class="pw_area">
                        <div class="input_row" id="pw_area">
                            <span class="input_box">
                                <input type="text" name="upw" id="upw" class="int" placeholder="비밀번호">
                            </span>
                        </div>
                    </div>
                    <button class="btn_login" type="button" onclick="login_ajax()">로그인</button>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>