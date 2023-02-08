package com.cre.domain;

import lombok.Data;

@Data
public class BoardVO {
	private Long post_num;
	private String category;
	private String writer;
	private String writer_id;
	private String title;
	private String content;
	private String post_date;
	private Long reply_count;
	private Long view_count;
	private Long heart_count;
}
