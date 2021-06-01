package com.site.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReplyVo {
	private int replyNum;
	private int boardNum; //게시글번호
	private String replyPw;
	private String replyContent;
	private String replyDate;

}
