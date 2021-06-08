package com.site.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.site.vo.Mvc_MemberVo;

@Mapper
public interface MemberMapper {

	Mvc_MemberVo selectLogin(Mvc_MemberVo mvc_MemberVo);


	
	
}
