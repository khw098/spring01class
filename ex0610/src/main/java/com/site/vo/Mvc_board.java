package com.site.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Mvc_board {

	private int bno;
	private String userid;
	private String btitle;
	private String bcontent;
	private Timestamp bdate;
	private int bhit; 
	private int bgroup; //댓글들 그룹
	private int bstep;  //댓글 몇번째 글인지 확인
	private int bindent; //댓글 들여쓰기
	private String fileName; //파일 이름
	
}
