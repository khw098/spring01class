package com.site.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.site.service.BoardService;
import com.site.vo.Mvc_board;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService; 
	
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	
				
	@RequestMapping("/reply") //답글페이지 호출
	public String reply(@RequestParam("bno") int bno,Model model) {
		Mvc_board mvc_board = boardService.boardModify(bno);
		model.addAttribute(mvc_board);
		return "/reply";
	}
	@RequestMapping("/replyDo") //답글저장
	public String replyDo(Mvc_board mvc_board,Model model) {
		//작성자-session,제목,내용
		boardService.boardReplyDo(mvc_board);
		return "redirect:/list";
	}
	
	@RequestMapping("/modify") //수정페이지 호출
	public String modify(@RequestParam("bno") int bno,Model model) {
		Mvc_board mvc_board = boardService.boardModify(bno);
		model.addAttribute(mvc_board);
		return "/modify";
	}
	
	@RequestMapping("/modifyDo") //수정저장 호출
	public String modifyDo(Mvc_board mvc_board) {
		//작성자-session,제목,내용
		boardService.boardModifyDo(mvc_board);
		return "redirect:/view?bno="+mvc_board.getBno();
	}
	@RequestMapping("/delete") //게시물 삭제
	public String delete(@RequestParam("bno") int bno) {
		boardService.boardDelete(bno);
		return "redirect:/list";
	}
	
	@RequestMapping("/write") //쓰기페이지 호출
	public String write() {
		return "/write";
	}
	
	@RequestMapping("/writeDo") //쓰기저장 호출
	public String writeDo(Mvc_board mvc_board) {
		//작성자-session,제목,내용
		System.out.println("test : "+mvc_board.getUserid());
		boardService.boardWriteDo(mvc_board);
		
		return "redirect:/list";
	}
	
	@RequestMapping("/list") //리스트페이지 호출
	public String list(@RequestParam @Nullable String page, Model model) {
		int listPage = 0;
		if(page == null) { // 넘어온 데이터가 없을때
			listPage = 1; // 1로 셋팅
		}else {
			listPage = Integer.parseInt(page);
		}
		
		
		Map<String,Object> map = boardService.boardListAll(listPage);
		model.addAttribute("map",map);
		return "/list";
	}
	
	
	
	
	
	
	
	@RequestMapping("/view") //뷰페이지 호출 view?bno=${bno}
	public String view(@RequestParam("bno") int bno,
			Model model) {
		//Mvc_board객체 1개 가져옴
		Mvc_board mvc_board = boardService.boardview(bno);
		System.out.println("test mvc_board : "+mvc_board.getBcontent());
		model.addAttribute("mvc_board",mvc_board);
		return "/view";
	}
	
	@RequestMapping("/view/{bno}")
	public String main(@PathVariable int bno, Model model) {
		//Mvc_board객체 1개 가져옴
		Mvc_board mvc_board = boardService.boardview(bno);
		System.out.println("test mvc_board : "+mvc_board.getBcontent());
		model.addAttribute("mvc_board",mvc_board);
		return "/view";
	}

}
