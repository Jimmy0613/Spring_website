package com.cre.website.service;

import java.util.List;

import com.cre.domain.MemberVO;

public interface MemberService {
	public void memberJoin(MemberVO mvo, String pwCheck);
	public List<MemberVO> memberList();
	public MemberVO getMember(String member_id);
	public MemberVO memberLogin(MemberVO mvo);
}
