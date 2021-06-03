package com.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.mapper.BoardMapper;
import com.site.vo.Mvc_board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;

	@Override //전체리스트 호출
	public List<Mvc_board> boardListAll() {
		List<Mvc_board> list = boardMapper.selectboardListAll();
		return list;
	}

	@Override  //뷰페이지 호출
	public Mvc_board boardview(int bno) {
		boardMapper.updatehit(bno); //조회수 1증가
		Mvc_board mvc_board = boardMapper.selectboardview(bno);
		return mvc_board;
	}

	@Override  //쓰기 저장
	public void boardWriteDo(Mvc_board mvc_board) {
		boardMapper.insertBoardWriteDo(mvc_board);
	}

	@Override //수정페이지 호출
	public Mvc_board boardModify(int bno) {
		Mvc_board mvc_board = boardMapper.selectBoardModify(bno);
		return mvc_board;
	}

	@Override //수정 저장
	public void boardModifyDo(Mvc_board mvc_board) {
		boardMapper.updateBoardModifyDo(mvc_board);
		
	}

	@Override //게시물 삭제
	public void boardDelete(int bno) {
		boardMapper.deleteBoardDelete(bno);
		
	}

	@Override //답글 저장
	public void boardReplyDo(Mvc_board mvc_board) {
		boardMapper.insertBoardReplyDoPlus(mvc_board);
		boardMapper.insertBoardReplyDo(mvc_board);
		
	}

}
