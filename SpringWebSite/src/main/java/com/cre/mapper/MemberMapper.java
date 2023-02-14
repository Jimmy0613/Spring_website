package com.cre.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;

public interface MemberMapper {
	public void join(MemberVO mvo);

	public List<MemberVO> memberList();

	public MemberVO getMember(String member_id);

	public List<BoardVO> myPost(@Param("member_id") String member_id, @Param("startIndex") int startIndex);

	public List<ReplyVO> myReply(@Param("member_id") String member_id, @Param("startIndex") int startIndex);

	public void myEmail(MemberVO mvo);

	public PageVO page(String member_id);

	public PageVO page2(String member_id);

	public int rpsCount(@Param("today") String today, @Param("member_id") String memeber_id);

	public void rps(@Param("member_id")String member_id, @Param("result")String result);
}
