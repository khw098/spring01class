package com.site.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.site.vo.ReplyVo;

@Mapper
public interface EventMapper {

	//댓글리스트, 카운트
	List<ReplyVo> selectReplyList();
	int selectReplyListCount();
	//댓글1개 insert
	int insertReply(ReplyVo replyVo);
	//댓글1개 select
	ReplyVo selectReplyOne(int replyNo);
	
	//댓글수정
	void updateReply(ReplyVo replyVo);
	
	//댓글 삭제
	int deleteReply(ReplyVo replyVo);

}
