package com.site.service;

import java.util.List;
import java.util.Map;

import com.site.vo.Mvc_board;

public interface BoardService {

	Map<String,Object> boardListAll(int page);

	Mvc_board boardview(int bno);

	void boardWriteDo(Mvc_board mvc_board);

	Mvc_board boardModify(int bno);

	void boardModifyDo(Mvc_board mvc_board);

	void boardDelete(int bno);

	void boardReplyDo(Mvc_board mvc_board);

}
