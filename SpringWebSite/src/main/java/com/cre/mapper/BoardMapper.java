package com.cre.mapper;

import java.util.List;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;

public interface BoardMapper {
	public List<BoardVO> list(int startIndex);
	public BoardVO read(Long post_num);
	public void delete(Long post_num);
	public void edit(BoardVO bvo);
	public PageVO page();
	public void write(BoardVO bvo);
}
