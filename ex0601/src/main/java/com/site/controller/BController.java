package com.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.vo.MemberVo;

@Controller
public class BController {

	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/form")
	public String form() {
		return "form";
	}
	
	@RequestMapping("/formOk")  //데이터전달형태로 변경
	@ResponseBody
	public MemberVo formOk(MemberVo memberVo) {
		System.out.println("데이터 확인 : "+memberVo.getId());
		//데이터 db저장
		//form.jsp 데이터전달
		
		
		return memberVo;  //formOk.jsp -> json데이터를 전달해줌.
	}
	
	
}
