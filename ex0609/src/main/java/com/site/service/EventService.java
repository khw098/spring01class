package com.site.service;

import java.util.List;
import java.util.Map;

import com.site.vo.ReplyVo;

public interface EventService {

	Map<String,Object> replyList();

	Map<String, Object> replyInsert(ReplyVo replyVoo);

	ReplyVo replyUpdate(ReplyVo replyVo);

}
