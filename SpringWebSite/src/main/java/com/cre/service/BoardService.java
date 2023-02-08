package com.cre.service;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;

public interface BoardService {
	public List<BoardVO> list(int startIndex);

	public PageVO page();

	public BoardVO read(Long post_num);

	public void delete(Long post_num);

	public void edit(BoardVO bvo);

	public void write(BoardVO bvo);
}
