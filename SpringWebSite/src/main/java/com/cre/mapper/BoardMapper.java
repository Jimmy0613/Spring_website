package com.cre.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.domain.ReportVO;

public interface BoardMapper {
	public List<BoardVO> listGeneral(@Param("startIndex") int startIndex);

	public List<BoardVO> listNotice(@Param("startIndex") int startIndex);

	public List<BoardVO> listAnonym(@Param("startIndex") int startIndex);

	public List<BoardVO> listPopular();

	public List<BoardVO> homeNotice();

	public List<BoardVO> homePopular();

	public String getWriterId(Long post_num);

	public BoardVO read(Long post_num);

	public void heart(@Param("post_num") Long post_num, @Param("writer_id") String writer_id,
			@Param("member_id") String member_id);

	public List<ReplyVO> listReply(Long post_num);

	public void reply(ReplyVO rvo);

	public void rePlus(ReplyVO rvo);

	public void view(Long post_num);

	public void write(BoardVO bvo);

	public void report(ReportVO rep);

	public List<ReportVO> listReport();

	public void postPlus(BoardVO bvo);

	public void delete(BoardVO bvo);

	public void delReply(ReplyVO rvo);

	public void edit(BoardVO bvo);

	public PageVO page(@Param("category") String category);

}
