package com.site.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.service.EventService;
import com.site.vo.ReplyVo;

@Controller
public class EventController {

	@Autowired
	EventService eventService;
	
	@RequestMapping("/event/event")
	public String event() {
		return "/event/event";
	}
	
	//댓글저장 - ajax
	@RequestMapping("/event/replyInsert")
	@ResponseBody
	public Map<String,Object> replyInsert(ReplyVo replyVo) {
		//댓글을 저장하면서 댓글을 가져옴.
		return eventService.replyInsert(replyVo);
	}
	
	//댓글수정 - ajax
	@RequestMapping("/event/replyUpdate")
	@ResponseBody
	public ReplyVo replyUpdate(ReplyVo replyVo) {
		System.out.println("controller getReplyNo : "+replyVo.getReplyNo());
		System.out.println("controller getReplyContent : "+replyVo.getReplyContent());
		//댓글을 수정하면서 댓글을 가져옴.
		return eventService.replyUpdate(replyVo);
	}
	
	
	
	@RequestMapping("/event/event_view")
	public String event_view(Model model) {
		//replyVo, replyCount 가져옴 
		Map<String,Object> map = eventService.replyList();
		model.addAttribute("map",map);
		return "/event/event_view";
	}
}
