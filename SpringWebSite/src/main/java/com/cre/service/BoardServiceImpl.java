package com.cre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public List<BoardVO> list(int startIndex) {
		log.info("게시판 리스트");
		return mapper.list(startIndex);
	}

	@Override
	public PageVO page() {
		return mapper.page();
	}
	@Override
	public BoardVO read(Long post_num) {
		log.info("글 읽기");
		return mapper.read(post_num);
	}

	@Override
	public void delete(Long post_num) {
		mapper.delete(post_num);
	}

	@Override
	public void edit(BoardVO bvo) {
		mapper.edit(bvo);
	}
	@Override
	public void write(BoardVO bvo) {
		log.info("글쓰기");
		mapper.write(bvo);
	}
}
