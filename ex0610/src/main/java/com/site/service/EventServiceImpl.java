package com.site.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.mapper.EventMapper;
import com.site.vo.ReplyVo;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	EventMapper eventMapper;
	
	@Override
	public Map<String,Object> replyList() {
		Map<String,Object> map = new HashMap<String, Object>();
		List<ReplyVo> replyList = eventMapper.selectReplyList();
		int replyCount = eventMapper.selectReplyListCount();
		
		map.put("replyList", replyList);
		map.put("replyCount", replyCount);
		
		return map;
	}

	@Override // 댓글저장
	public Map<String, Object> replyInsert(ReplyVo replyVo) {
		Map<String,Object> map = new HashMap<String, Object>();
		//댓글저장 후 댓글 가져오기
		int replyNo = eventMapper.insertReply(replyVo);
		System.out.println("impl replyNo : "+ replyNo);
		System.out.println("impl replyVo.getReplyNo() : "+ replyVo.getReplyNo());
		
		// replyNo키를 가지고 Vo데이터 가져오기
		ReplyVo vo = eventMapper.selectReplyOne(replyVo.getReplyNo());
		//댓글 카운트
		int replyCount = eventMapper.selectReplyListCount();
		
		map.put("replyVo", vo);
		map.put("replyCount", replyCount);
		
		return map;
	}

	@Override  //댓글수정
	public ReplyVo replyUpdate(ReplyVo replyVo) {
		System.out.println("impl replyno :"+replyVo.getReplyNo());
		//수정후, 1개 vo데이터 가져오기
		eventMapper.updateReply(replyVo);
		
		ReplyVo vo = eventMapper.selectReplyOne(replyVo.getReplyNo());
		System.out.println("impl content : "+vo.getReplyContent());
		return vo;
	}

	@Override  //댓글삭제
	public Map<String, Object> replyDelete(ReplyVo replyVo) {
		Map<String,Object> map = new HashMap<String, Object>();
		int result = eventMapper.deleteReply(replyVo);
		int replyCount = eventMapper.selectReplyListCount();
		//결과 msg 넣어줌.
		System.out.println("impl result : "+result);
		
		String msg = "";
		if(result==1) {
			msg="댓글 삭제가 완료되었습니다.";
		}else {
			msg="댓글 삭제처리에 에러가 발생했습니다.";
		}
		map.put("replyCount",replyCount);
		map.put("msg", msg);
		return map;
	}

}
