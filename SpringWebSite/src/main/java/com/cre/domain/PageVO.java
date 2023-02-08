package com.cre.domain;

import lombok.Data;

@Data
public class PageVO {
	public final static int PER_PAGE = 10;
	public final static int PAGE_BLOCK = 5;
	private Long count;
	private int totalPage = 1;
	private int currentPageBlock = 1;

	public void getPage(int currentPage) {
		if (this.count % PER_PAGE == 0) {
			this.totalPage = (int) (this.count / PER_PAGE);
		} else {
			this.totalPage = (int) (this.count / PER_PAGE) + 1;
		}
		if (currentPage % PAGE_BLOCK == 0) {
			this.currentPageBlock = currentPage / PAGE_BLOCK;
		} else {
			this.currentPageBlock = currentPage / PAGE_BLOCK + 1;
		}
	}

}
