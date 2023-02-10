package com.cre.website.service;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;

public interface MemberService {

	public void memberJoin(MemberVO mvo, String pwCheck);

	public List<MemberVO> memberList();

	public MemberVO getMember(String member_id);

	public MemberVO memberLogin(MemberVO mvo);

	public List<BoardVO> myPost(String member_id, int startIndex);

	public List<ReplyVO> myReply(String member_id, int startIndex);

	public PageVO page(String member_id);

	public PageVO page2(String member_id);
}
