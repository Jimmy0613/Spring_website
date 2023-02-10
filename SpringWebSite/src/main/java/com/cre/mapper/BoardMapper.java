package com.cre.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;

public interface BoardMapper {
	public List<BoardVO> listBoard(@Param("startIndex") int startIndex, @Param("category") String category);

	public List<BoardVO> listPopular();

	public BoardVO read(Long post_num);

	public void heart(@Param("post_num") Long post_num, @Param("writer_id") String writer_id,
			@Param("member_id") String member_id);

	public List<ReplyVO> listReply(Long post_num);

	public void reply(ReplyVO rvo);

	public void rePlus(ReplyVO rvo);

	public void view(Long post_num);

	public void write(BoardVO bvo);

	public void postPlus(BoardVO bvo);

	public void delete(BoardVO bvo);

	public void delReply(ReplyVO rvo);

	public void edit(BoardVO bvo);

	public PageVO page(@Param("category") String category);

}
