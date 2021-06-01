package com.site.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.vo.MemberVo;
import com.site.vo.ReplyVo;

@Controller
public class BController {

	static int count=0;
	static int replyNumber=2;
	
	
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	@RequestMapping("/loginFail")
	public String loginFail() {
		return "loginFail";
	}
	@RequestMapping("/logOut")
	public String logOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/index";
	}
	@RequestMapping("/login_check")
	public String login_check(HttpServletRequest request, MemberVo memberVo) {
		//db접근해서 memberVo.getId()-> 데이터가 있으면 로그인, 에러띄워주면 됨.
		String id="admin";
		String pw="1111";
		
		if(memberVo.getId().equals(id) && memberVo.getPw().equals(pw)) {
			System.out.println("로그인성공");
			HttpSession session = request.getSession();
			session.setAttribute("session_flag", "success");
			session.setAttribute("session_id", memberVo.getId());
			return "redirect:/index";
		}else {
			System.out.println("로그인실패");
			return "loginFail";
		}
		
	}
	
	@RequestMapping("/event/event_view")
	public String event_view() {
		return "event/event_view";
	}
	@RequestMapping("/event/reply_ajax")
	@ResponseBody
	public Map<String, Object> event_ajax(ReplyVo replyVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dateTime = sdf.format(d);
		replyVo.setReplyDate(dateTime);
		replyVo.setReplyNum(++replyNumber);
		//db -> replyNum,sysdate   
		//replyNum,boardNum,replyPw,replyContent,dateTime -> replyVo
		int replyCount=3;
		map.put("replyCount", replyCount);
		map.put("replyVo", replyVo);
		
		
		return map;
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
		memberVo.setNum(++BController.count);
		
		//form.jsp 데이터전달
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dateTime = sdf.format(d);
		
		
		
		
		return memberVo;  //formOk.jsp -> json데이터를 전달해줌.
	}
	
	
}
