package com.site.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.site.mapper.BoardMapper;
import com.site.vo.Mvc_board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;

	@Override //전체리스트 호출
	public Map<String,Object> boardList(int page) {
		Map<String,Object> map = new HashMap<String, Object>();
		
		int limit = 10; //페이지당 몇개의 게시글을 가져올지 정의(10,20,30...)
		
		//[[게시글데이터 가져오기 : 1~10까지 게시글 데이터 가져오기 ]]
		int startrow = (page-1)*limit+1; //처음페이지 계산공식 1,11,21,31,41....
		int endrow = startrow+limit-1;   //마지막페이지 계산공식 10,20,30,40.....
		
		
		List<Mvc_board> list = boardMapper.selectboardList(startrow,endrow);
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
        List<Mvc_board> list = null; 
		int limit = 10; //페이지당 몇개의 게시글을 가져올지 정의(10,20,30...)
		
		//[[게시글데이터 가져오기 : 1~10까지 게시글 데이터 가져오기 ]]
		int startrow = (page-1)*limit+1; //처음페이지 계산공식 1,11,21,31,41....
		int endrow = startrow+limit-1;   //마지막페이지 계산공식 10,20,30,40.....
		System.out.println("impl search :"+search);
		
		//[[ 하단 넘버링 계산 : startpage,endpage,maxpage 처리 ]]
		int listCount=0;  //총게시글 수
		if(category.equals("all")) {
			System.out.println("impl all : "+category );
			list = boardMapper.selectBoardListSearchAll(startrow,endrow,search);
			//전체(All)로 검색한 게시글수
			listCount = boardMapper.selectBoardSearchAllCount(search);
		}else {
			System.out.println("impl category : "+category );
			list = boardMapper.selectBoardListSearch(startrow,endrow,category,search);
			//제목,내용으로 검색한 게시글수
			listCount = boardMapper.selectBoardSearchCount(category,search);
		}
		
		
		
		
		
		
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
	public Map<String,Object> boardview(int bno) {
		Map<String,Object> map = new HashMap<String, Object>();
		boardMapper.updatehit(bno); //조회수 1증가
		Mvc_board mvc_board = boardMapper.selectboardview(bno);
		//이전글
		Mvc_board boardPre = boardMapper.selectBoardViewPre(bno);
		//다음글
		Mvc_board boardNext = boardMapper.selectBoardViewNext(bno);
		map.put("mvc_board", mvc_board);
		map.put("boardPre", boardPre);
		map.put("boardNext", boardNext);
		return map;
	}

	@Override  //쓰기 저장
	public void boardWriteDo(Mvc_board mvc_board,MultipartFile file) {
		
		// 파일저장위치
		String fileUrl = "C:/Users/3실습실/git/spring01class/ex0610/src/main/resources/static/upload/";
		// - 파일이름중복방지
		long time = System.currentTimeMillis();
		String uploadFileName = time+"_"+file.getOriginalFilename(); 
		// - 파일저장
		File f = new File(fileUrl+uploadFileName); //
		// - 파일전송
		try {
			file.transferTo(f);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 파일이름을 Vo저장
		mvc_board.setFileName(uploadFileName);
		// db저장
		boardMapper.insertBoardWriteDo(mvc_board);
		
		System.out.println("db저장 전 uploadFileName : "+uploadFileName);
	}

	@Override //수정페이지 호출
	public Mvc_board boardModify(int bno) {
		Mvc_board mvc_board = boardMapper.selectBoardModify(bno);
		return mvc_board;
	}

	@Override //수정 저장
	public void boardModifyDo(Mvc_board mvc_board,MultipartFile file) {
		
		//파일이 변경되었을때
		if(file.getSize() != 0) {
			// 파일저장위치
			String fileUrl = "C:/Users/3실습실/git/spring01class/ex0610/src/main/resources/static/upload/";
			// - 파일이름중복방지
			long time = System.currentTimeMillis();
			String uploadFileName = time+"_"+file.getOriginalFilename(); 
			// - 파일저장
			File f = new File(fileUrl+uploadFileName); //
			// - 파일전송
			try {
				file.transferTo(f);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 파일이름을 Vo저장
			mvc_board.setFileName(uploadFileName);
		}
		
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
