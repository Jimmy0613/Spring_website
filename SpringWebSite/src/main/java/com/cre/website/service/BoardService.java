package com.cre.website.service;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.domain.ReportVO;

public interface BoardService {

	public List<BoardVO> listGeneral(int startIndex);

	public List<BoardVO> listNotice(int startIndex);

	public List<BoardVO> listAnonym(int startIndex);

	public List<BoardVO> listPopular();

	public List<BoardVO> homeNotice();

	public List<BoardVO> homePopular();

	public PageVO page(String category);

	public void write(BoardVO bvo);

	public String getWriterId(Long post_num);

	public void report(ReportVO rep);

	public List<ReportVO> listReport();

	public void delete(BoardVO bvo);

	public BoardVO read(Long post_num);

	public void heart(Long post_num, String writer_id, String member_id);

	public List<ReplyVO> listReply(Long post_num);

	public void reply(ReplyVO rvo);

	public void view(Long post_num);

	public void delReply(ReplyVO rvo);

	public void edit(BoardVO bvo);

}
