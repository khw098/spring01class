package com.site.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.mapper.MemberMapper;
import com.site.vo.Mvc_MemberVo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	@Override //로그인 확인
	public Mvc_MemberVo login(Mvc_MemberVo mvc_MemberVo) {
		return memberMapper.selectLogin(mvc_MemberVo);
	}

}
