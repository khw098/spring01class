package com.site.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.site.vo.Mvc_board;

public interface BoardService {

	Map<String,Object> boardList(int page);
	Map<String, Object> boardListSearch(int page, String category, String search);

	Map<String,Object> boardview(int bno);

	void boardWriteDo(Mvc_board mvc_board,MultipartFile file);

	Mvc_board boardModify(int bno);

	void boardModifyDo(Mvc_board mvc_board,MultipartFile file);

	void boardDelete(int bno);

	void boardReplyDo(Mvc_board mvc_board);


}
