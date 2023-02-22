package com.cre.website.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.domain.ReportVO;
import com.cre.domain.SearchVO;
import com.cre.mapper.BoardMapper;
import com.cre.mapper.SearchMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private SearchMapper searchMapper;

	@Override
	public List<BoardVO> homeNotice() {
		return mapper.homeNotice();
	}

	@Override
	public List<BoardVO> homePopular() {
		return mapper.homePopular();
	}

	@Override
	public List<BoardVO> listBoard(int startIndex, String category) {
		if (category.equals("popular"))
			return mapper.listPopular();
		else
			return mapper.listBoard(startIndex, category);
	}

	@Override
	public PageVO page(String category) {
		return mapper.page(category);
	}

	@Override
	public HashMap<String, Object> search(int startIndex, SearchVO svo) {
		HashMap<String, Object> search;
		switch (svo.getCategory()) {
		case "all":
			switch (svo.getKey()) {
			case "all":
				search = new HashMap<>();
				search.put("list", searchMapper.searchMain(startIndex, svo.getKeyword()));
				search.put("page", searchMapper.smPage(svo));
				return search;
			default:
				search = new HashMap<>();
				search.put("list", searchMapper.searchAllCategory(startIndex, svo.getKey(), svo.getKeyword()));
				search.put("page", searchMapper.sacPage(svo));
				return search;
			}
		default:
			switch (svo.getKey()) {
			case "all":
				search = new HashMap<>();
				search.put("list", searchMapper.searchCategory(startIndex, svo.getCategory(), svo.getKeyword()));
				search.put("page", searchMapper.scPage(svo));
				return search;

			default:
				search = new HashMap<>();
				search.put("list", searchMapper.search(startIndex, svo.getCategory(), svo.getKey(), svo.getKeyword()));
				search.put("page", searchMapper.sPage(svo));
				return search;

			}
		}
	}

	@Override
	public BoardVO read(Long post_num) {
		return mapper.read(post_num);
	}

	@Override
	public String getWriterId(Long post_num) {
		return mapper.getWriterId(post_num);
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
	public void report(ReportVO rep) {
		mapper.report(rep);
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
