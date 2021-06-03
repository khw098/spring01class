package com.site.service;

import java.util.List;

import com.site.vo.Mvc_board;

public interface BoardService {

	List<Mvc_board> boardListAll();

	Mvc_board boardview(int bno);

	void boardWriteDo(Mvc_board mvc_board);

	Mvc_board boardModify(int bno);

	void boardModifyDo(Mvc_board mvc_board);

	void boardDelete(int bno);

	void boardReplyDo(Mvc_board mvc_board);

}
