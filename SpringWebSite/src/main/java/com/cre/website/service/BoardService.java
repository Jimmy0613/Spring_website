package com.cre.website.service;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;

public interface BoardService {
	public List<BoardVO> listBoard(int startIndex, String category);

	public List<BoardVO> listPopular();

	public PageVO page(String category);

	public void write(BoardVO bvo);

	public void delete(BoardVO bvo);

	public BoardVO read(Long post_num);

	public void heart(Long post_num, String writer_id, String member_id);
	
	public List<ReplyVO> listReply(Long post_num);

	public void reply(ReplyVO rvo);

	public void view(Long post_num);

	public void delReply(ReplyVO rvo);

	public void edit(BoardVO bvo);

}