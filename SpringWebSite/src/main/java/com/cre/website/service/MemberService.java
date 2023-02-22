package com.cre.website.service;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;

public interface MemberService {

	public void memberJoin(MemberVO mvo);

	public List<MemberVO> memberList();

	public int idCheck(String member_id);

	public MemberVO getMember(String member_id);

	public String memberLogin(MemberVO mvo);

	public List<BoardVO> myPost(String member_id, int startIndex);

	public List<ReplyVO> myReply(String member_id, int startIndex);

	public void myEmail(MemberVO mvo);

	public PageVO page(String member_id, String table);

	public int getTodayCount(String today, String member_id);

	public void rps(String member_id, String result);
}
