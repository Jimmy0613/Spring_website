package com.cre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.MemberVO;
import com.cre.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public void join(MemberVO mvo) {
		log.info("회원가입");
		mapper.join(mvo);
	}
	
	@Override
	public List<MemberVO> memberList() {
		log.info("로그인");
		return mapper.memberList();
	}
	
	@Override
	public MemberVO getMember(String member_id) {
		return mapper.getMember(member_id);
	}
}
