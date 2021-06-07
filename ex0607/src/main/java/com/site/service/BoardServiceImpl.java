package com.site.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.mapper.BoardMapper;
import com.site.vo.Mvc_board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;

	@Override //전체리스트 호출
	public Map<String,Object> boardListAll(int page) {
		Map<String,Object> map = new HashMap<String, Object>();
		
		int limit = 10; //페이지당 몇개의 게시글을 가져올지 정의(10,20,30...)
		
		//[[게시글데이터 가져오기 : 1~10까지 게시글 데이터 가져오기 ]]
		int startrow = (page-1)*limit+1; //처음페이지 계산공식 1,11,21,31,41....
		int endrow = startrow+limit-1;   //마지막페이지 계산공식 10,20,30,40.....
		
		List<Mvc_board> list = boardMapper.selectboardListAll(startrow,endrow);
		
		//[[ 하단 넘버링 계산 : startpage,endpage,maxpage 처리 ]]
		int listCount=0;  //총게시글 수
		listCount = boardMapper.selectBoardCount();
		//하단 최대 넘버링페이지 
		int maxPage = (int)((double)listCount/limit+0.95); 
		//하단 시작 넘버링페이지
		int startPage = (((int) ((double)page / 10 + 0.95)) - 1) * 10 + 1;
		//하단 끝 넘버링페이지
		int endPage = maxPage;
		// 1,2,3,4,5,6,7,8,9,10 -> 10개가 모두 있을 경우는 10을 endPage에 넣어줌.
		if (endPage>startPage+10-1) {
			endPage=startPage+10-1;
		}

		// list,page(현재페이지),listCount,startPage,endPage,maxPage 6개 리턴해서 보내줌.
		map.put("list", list);
		map.put("page", page);
		map.put("listCount", listCount);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("maxPage", maxPage);
		
		return map;
	}

	@Override  // 검색리스트 호출
	public Map<String, Object> boardListSearch(int page, String category, String search) {
        Map<String,Object> map = new HashMap<String, Object>();
		
		int limit = 10; //페이지당 몇개의 게시글을 가져올지 정의(10,20,30...)
		
		//[[게시글데이터 가져오기 : 1~10까지 게시글 데이터 가져오기 ]]
		int startrow = (page-1)*limit+1; //처음페이지 계산공식 1,11,21,31,41....
		int endrow = startrow+limit-1;   //마지막페이지 계산공식 10,20,30,40.....
		System.out.println("impl search :"+search);
		List<Mvc_board> list = boardMapper.selectBoardListSearch(startrow,endrow,search);
		
		//[[ 하단 넘버링 계산 : startpage,endpage,maxpage 처리 ]]
		int listCount=0;  //총게시글 수
		listCount = boardMapper.selectBoardSearchCount(search);
		System.out.println("listCount : "+listCount);
		//하단 최대 넘버링페이지 
		int maxPage = (int)((double)listCount/limit+0.95); 
		//하단 시작 넘버링페이지
		int startPage = (((int) ((double)page / 10 + 0.95)) - 1) * 10 + 1;
		//하단 끝 넘버링페이지
		int endPage = maxPage;
		// 1,2,3,4,5,6,7,8,9,10 -> 10개가 모두 있을 경우는 10을 endPage에 넣어줌.
		if (endPage>startPage+10-1) {
			endPage=startPage+10-1;
		}

		// list,page(현재페이지),listCount,startPage,endPage,maxPage 6개 리턴해서 보내줌.
		map.put("list", list);
		map.put("page", page);
		map.put("listCount", listCount);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("maxPage", maxPage);
		map.put("category", category);
		map.put("search", search);
		
		return map;
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
