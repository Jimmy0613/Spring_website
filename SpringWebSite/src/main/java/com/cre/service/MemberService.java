package com.cre.service;

import java.util.List;

import com.cre.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO mvo);
	public List<MemberVO> memberList();
	public MemberVO getMember(String member_id);
}
