package com.site.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReplyVo {
	private int replyNo; //자동입력
	private String userid;
	private int bno; //게시글번호
	private String replyPw;
	private String replyContent;
	private String replyDate; //자동입력

}
