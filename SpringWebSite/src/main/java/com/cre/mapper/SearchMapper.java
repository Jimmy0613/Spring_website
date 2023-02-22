package com.cre.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.domain.SearchVO;

public interface SearchMapper {
	public List<BoardVO> searchMain(@Param("startIndex") int startIndex, @Param("keyword") String keyword);

	public PageVO smPage(SearchVO svo);

	public List<BoardVO> searchAllCategory(@Param("startIndex") int startIndex, @Param("key") String key,
			@Param("keyword") String keyword);

	public PageVO sacPage(SearchVO svo);

	public List<BoardVO> searchCategory(@Param("startIndex") int startIndex, @Param("category") String category,
			@Param("keyword") String keyword);

	public PageVO scPage(SearchVO svo);

	public List<BoardVO> search(@Param("startIndex") int startIndex, @Param("category") String category,
			@Param("key") String key, @Param("keyword") String keyword);

	public PageVO sPage(SearchVO svo);

}
