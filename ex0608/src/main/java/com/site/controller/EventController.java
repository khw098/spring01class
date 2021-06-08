package com.site.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EventController {

	@RequestMapping("/event/event_view")
	public String event_view(HttpServletRequest request ) {
		return "/event/event_view";
	}
}
