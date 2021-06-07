package com.site.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.site.vo.Mvc_board;

@Mapper
public interface BoardMapper {

	// 전체리스트
	List<Mvc_board> selectboardListAll(int startrow, int endrow);
	int selectBoardCount();

	// 검색리스트
	List<Mvc_board> selectBoardListSearch(int startrow, int endrow, String search);
	int selectBoardSearchCount(String search);
	
	// 뷰페이지 
	Mvc_board selectboardview(int bno);

	// 조회수증가
	void updatehit(int bno);

	// 글쓰기
	void insertBoardWriteDo(Mvc_board mvc_board);

	Mvc_board selectBoardModify(int bno);

	void updateBoardModifyDo(Mvc_board mvc_board);

	void deleteBoardDelete(int bno);

	void insertBoardReplyDo(Mvc_board mvc_board);

	void insertBoardReplyDoPlus(Mvc_board mvc_board);


}
