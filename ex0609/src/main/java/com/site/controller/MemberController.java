package com.site.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.service.MemberService;
import com.site.vo.Mvc_MemberVo;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	@GetMapping("/logOut")
	public String loginOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "/index";
	}
	
	@RequestMapping(value="/login_ajax")
	@ResponseBody
	public Map<String,Object> login_ajax(Mvc_MemberVo mvc_MemberVo,HttpServletRequest request,Model model) {
		
		Map<String,Object> map=new HashMap<String, Object>();
		Mvc_MemberVo mVo = memberService.login(mvc_MemberVo); //전체리스트 가져오기
		map.put("mVo",mVo);
		if(mVo==null) {
			map.put("flag", "fail");
			map.put("msg", "아이디와 패스워드가 일치하지 않습니다.");
		}else {
			map.put("flag", "success");
			map.put("msg", "로그인 성공!");
			HttpSession session = request.getSession();
			session.setAttribute("session_flag","success");
			session.setAttribute("session_id", mVo.getUserid());
			session.setAttribute("unname", mVo.getUnname());
		}
		return map;
	}
	
	
	
	

}
