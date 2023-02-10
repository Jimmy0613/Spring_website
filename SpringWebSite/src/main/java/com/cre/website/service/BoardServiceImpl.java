package com.cre.website.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public List<BoardVO> listBoard(int startIndex, String category) {
		return mapper.listBoard(startIndex, category);
	}

	@Override
	public List<BoardVO> listPopular() {
		return mapper.listPopular();
	}

	@Override
	public List<BoardVO> homeNotice() {
		return mapper.homeNotice();
	}

	@Override
	public List<BoardVO> homePopular() {
		return mapper.homePopular();
	}

	@Override
	public PageVO page(String category) {
		return mapper.page(category);
	}

	@Override
	public BoardVO read(Long post_num) {
		return mapper.read(post_num);
	}

	@Override
	public void heart(Long post_num, String writer_id, String member_id) {
		mapper.heart(post_num, writer_id, member_id);
	}

	@Override
	public List<ReplyVO> listReply(Long post_num) {
		return mapper.listReply(post_num);
	}

	@Override
	public void reply(ReplyVO rvo) {
		mapper.reply(rvo);
		mapper.rePlus(rvo);
	}

	@Override
	public void view(Long post_num) {
		mapper.view(post_num);
	}

	@Override
	public void write(BoardVO bvo) {
		mapper.write(bvo);
		mapper.postPlus(bvo);
	}

	@Override
	public void delete(BoardVO bvo) {
		mapper.delete(bvo);
	}

	@Override
	public void delReply(ReplyVO rvo) {
		mapper.delReply(rvo);
	}

	@Override
	public void edit(BoardVO bvo) {
		mapper.edit(bvo);
	}

}
